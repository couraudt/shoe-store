# frozen_string_literal: true

class StoreEvent < ApplicationRecord
  WS_CHANNEL_NAME = 'StoreModelInventoryChannel'

  belongs_to :store
  belongs_to :store_model

  validates :store, :store_model, :inventory, presence: true
  validates :inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_commit :update_inventory
  after_commit :broadcast_event

  private

  # Update related shoe model's inventory
  def update_inventory
    # Use last received event stored in db rather than this one to avoid concurrency on high volume of events
    store_model.update_column(:inventory, StoreEvent.where(store_model_id: store_model_id).order(created_at: :desc).first.inventory)
  end

  # Send created events to ActiveAdmin Dashboard
  def broadcast_event
    ActionCable.server.broadcast('dashboard', { inventory: inventory, store: store, store_model: store_model })
  end
end
