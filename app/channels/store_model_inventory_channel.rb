# frozen_string_literal: true

class StoreModelInventoryChannel < ApplicationCable::Channel
  def receive(data)
    UpdateInventoryJob.perform_later(data)
  end
end
