# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::ModelsController do
  let_it_be(:store) { create(:store) }
  let_it_be(:store_model) { create(:store_model, store: store) }

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index, params: { store_id: store.id }
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      get :show, params: { store_id: store.id, id: store_model.id }
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end
