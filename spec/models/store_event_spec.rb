# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreEvent do
  let_it_be(:store) { create(:store) }
  let_it_be(:store_model) { create(:store_model, store: store) }

  context 'validates presence of store' do
    it 'not be valid with empty store_id' do
      expect(build_stubbed(:store_event, store_id: nil)).to_not be_valid
    end

    it 'not be valid with non existent store' do
      expect(build_stubbed(:store_event, store_id: 1337)).to_not be_valid
    end

    it 'be valid with a existent store' do
      expect(build_stubbed(:store_event, store: store)).to be_valid
    end
  end

  context 'validates presence of store_model' do
    it 'not be valid with empty store_model' do
      expect(build_stubbed(:store_event, store_model_id: nil)).to_not be_valid
    end

    it 'not be valid with non existent store_model' do
      expect(build_stubbed(:store_event, store_model_id: 1337)).to_not be_valid
    end

    it 'be valid with a existent store_model' do
      expect(build_stubbed(:store_event, store_model: store_model)).to be_valid
    end
  end

  it 'update related inventory' do
    create(:store_event, store: store, store_model: store_model)
    last_event = create(:store_event, store: store, store_model: store_model)
    expect(store_model.inventory).to eq(last_event.inventory)
  end
end
