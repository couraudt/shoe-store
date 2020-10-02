# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Store do
  let_it_be(:store) { create(:store, :with_models) }

  it 'validate uniqueness of name' do
    expect(build_stubbed(:store, name: store.name)).to_not be_valid
  end

  it 'validate presence of name' do
    expect(build_stubbed(:store, name: nil)).to_not be_valid
  end

  it 'destroy cascade associated models' do
    store_model = store.models.first
    store.destroy
    expect(StoreModel.exists?(id: store_model.id)).to be_falsey
  end
end
