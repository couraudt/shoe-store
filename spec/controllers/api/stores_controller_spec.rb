# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::StoresController do
  let_it_be(:store) { create(:store) }

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      get :show, params: { id: store.id }
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end
