require 'rails_helper'

RSpec.describe Store, type: :model do
  it 'validate uniqueness of name' do
    store = create(:store)
    expect(build_stubbed(:store, name: store.name)).to_not be_valid
  end

  it 'validate presence of name' do
    expect(build_stubbed(:store, name: nil)).to_not be_valid
  end
end
