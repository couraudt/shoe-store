# frozen_string_literal: true

class UpdateInventoryJob < ApplicationJob
  queue_as :inventory

  def perform(data, retries = 0)
    Rails.logger.warn "Bad data found when parsing #{data}. Exiting" and return if %w[store model inventory].any? { |attr| !data[attr] || data[attr].blank? }

    # If any of the information aren't valid, we rollback any changes (like store or models creation)
    ActiveRecord::Base.transaction do
      store = Store.where(name: data['store']).first_or_create!
      model = store.models.where(name: data['model']).first_or_create!
      model.events.create!(store: store, inventory: data['inventory'])
    rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid => e
      Rails.logger.warn "Can not save event with #{data}. Error: #{e}"
      if retries < 3
        self.class.set(wait: 10.seconds).perform_later(data, retries + 1)
      else
        Rails.logger.error "Error while saving event with #{data}. Error: #{e}"
      end
      raise ActiveRecord::Rollback
    end
  end
end
