# frozen_string_literal: true

class StoreModelInventoryChannel < ApplicationCable::Channel
  def receive(data)
    Rails.logger.info "receive #{data}"
  end
end
