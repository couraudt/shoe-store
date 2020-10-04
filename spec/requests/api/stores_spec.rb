# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stores API' do
  let_it_be(:store) { create(:store, :with_models) }
  let(:attr) { %w[id name models_count] }
  let(:json) { JSON.parse(response.body) }

  describe 'GET /api/stores' do
    before { get api_stores_path }

    it 'returns json array of stores' do
      expect(json.count).to eq(1)
    end

    it 'has the required attributes with value' do
      attr.each do |attribute|
        expect(json[0][attribute]).to eq(store[attribute])
      end
    end

    it 'has the required number of models' do
      expect(json[0]['models'].count).to eq(store.models_count)
    end
  end

  describe 'GET /api/stores/:id' do
    context 'valid store id' do
      before { get api_store_path(store) }

      it 'has the required attributes with value' do
        attr.each do |attribute|
          expect(json[attribute]).to eq(store[attribute])
        end
      end

      it 'has the required number of models' do
        expect(json['models'].count).to eq(store.models_count)
      end
    end

    context 'invalid store id' do
      it 'returns 404 message' do
        get api_store_path(1337)
        expect(json['code']).to eq('404')
        expect(json['message']).to eq('Not found')
      end
    end
  end
end
