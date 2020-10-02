# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreModel do
  let_it_be(:store) { create(:store) }

  context 'validates presence of store' do
    it 'not be valid with empty store_id' do
      expect(build_stubbed(:store_model, store_id: nil)).to_not be_valid
    end

    it 'not be valid with non existent store' do
      expect(build_stubbed(:store_model, store_id: 1337)).to_not be_valid
    end

    it 'be valid with a existent store' do
      expect(build_stubbed(:store_model, store: store)).to be_valid
    end
  end

  context 'validates uniqueness of name' do
    let_it_be(:store_model) { create(:store_model, store: store) }

    it 'not be valid with same store' do
      expect(build_stubbed(:store_model, name: store_model.name, store: store_model.store)).to_not be_valid
    end

    it 'be valid with another store' do
      expect(build_stubbed(:store_model, name: store_model.name)).to be_valid
    end
  end

  it 'updates store counter cache' do
    create(:store_model, store: store)
    expect(store.models_count).to eq(1)
  end
end
