# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateInventoryJob do
  let_it_be(:store) { create(:store) }
  let_it_be(:store_model) { create(:store_model, store: store) }

  context 'with existing data' do
    let(:data) { { 'store' => store.name, 'model' => store_model.name, 'inventory' => 42 } }

    it 'do not creates a store in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { Store.count }.by(0)
    end

    it 'do not creates a store model in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreModel.count }.by(0)
    end

    it 'creates an event in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreEvent.count }.by(1)
    end
  end

  context 'with missing store' do
    let(:data) { { 'store' => 'New Store', 'model' => store_model.name, 'inventory' => 42 } }

    it 'creates a store in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { Store.count }.by(1)
    end

    it 'creates a store model in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreModel.count }.by(1)
    end

    it 'creates an event in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreEvent.count }.by(1)
    end
  end

  context 'with missing store model' do
    let(:data) { { 'store' => store.name, 'model' => 'New Model', 'inventory' => 42 } }

    it 'do not creates a store in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { Store.count }.by(0)
    end

    it 'creates a store model in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreModel.count }.by(1)
    end

    it 'creates an event in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreEvent.count }.by(1)
    end
  end

  context 'with invalid data' do
    let(:data) { { 'store' => '', 'model' => store_model.name, 'inventory' => 42 } }

    it 'do not creates a store in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { Store.count }.by(0)
    end

    it 'do not creates a store model in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreModel.count }.by(0)
    end

    it 'do not creates an event in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreEvent.count }.by(0)
    end
  end

  context 'with missing data' do
    let(:data) { { 'model' => store_model.name, 'inventory' => 42 } }

    it 'do not creates a store in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { Store.count }.by(0)
    end

    it 'do not creates a store model in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreModel.count }.by(0)
    end

    it 'do not creates an event in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreEvent.count }.by(0)
    end
  end

  context 'with invalid inventory' do
    let(:data) { { 'store' => 'New Store', 'model' => store_model.name, 'inventory' => -1 } }

    it 'do not creates a store in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { Store.count }.by(0)
    end

    it 'do not creates a store model in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreModel.count }.by(0)
    end

    it 'do not creates an event in db' do
      expect { UpdateInventoryJob.perform_now(data) }.to change { StoreEvent.count }.by(0)
    end
  end
end
