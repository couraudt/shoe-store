# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Store Models API' do
  let_it_be(:store) { create(:store) }
  let_it_be(:store_model) { create(:store_model, store: store) }
  let(:attr) { %w[id store_id name inventory] }
  let(:json) { JSON.parse(response.body) }

  describe 'GET /api/stores/:store_id/models' do
    before { get api_store_models_path(store_id: store.id) }

    it 'returns json array of models' do
      expect(json.count).to eq(1)
    end

    it 'has the required attributes with value' do
      attr.each do |attribute|
        expect(json[0][attribute]).to eq(store_model[attribute])
      end
    end
  end

  describe 'GET /api/stores/:store_id/models/:id' do
    context 'valid store_model id' do
      before { get api_store_model_path(store_id: store.id, id: store_model.id) }

      it 'has the required attributes with value' do
        attr.each do |attribute|
          expect(json[attribute]).to eq(store_model[attribute])
        end
      end
    end

    context 'invalid store id' do
      it 'returns 404 message' do
        get api_store_model_path(store_id: store.id, id: 1337)
        expect(json['code']).to eq('404')
        expect(json['message']).to eq('Not found')
      end
    end
  end
end
