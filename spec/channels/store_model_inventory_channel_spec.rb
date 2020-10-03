# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreModelInventoryChannel, type: :channel do
  let(:data) { { 'store' => 'New Store', 'model' => 'New Model', 'inventory' => 42 } }

  it 'enqueue a job when receiving data' do
    expect { subscribe.receive(data) }.to have_enqueued_job(UpdateInventoryJob).with(data)
  end
end
