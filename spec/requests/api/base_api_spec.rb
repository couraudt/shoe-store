# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Base Controller API' do
  let(:json) { JSON.parse(response.body) }

  it 'have no cookie header' do
    get api_stores_path
    expect(response.headers.key?('Set-Cookie')).to be_falsey
  end

  context 'with invalid route' do
    it 'returns 404 not found' do
      get '/api/do/not/exists'
      expect(json['code']).to eq('404')
      expect(json['message']).to eq('Not found')
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'with invalid id' do
    it 'returns 404 not found' do
      get api_store_path(1337)
      expect(json['code']).to eq('404')
      expect(json['message']).to eq('Not found')
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'with internal error' do
    it 'returns 500 internal error' do
      # See Api::BaseController#rescue_from(StandardError)
      ENV['CATCH_EXCEPTION_DURING_TEST'] = '1'
      allow_any_instance_of(Api::StoresController).to receive(:index).and_raise(StandardError.new('error'))
      get api_stores_path
      expect(json['code']).to eq('500')
      expect(json['message']).to eq('Internal Server Error')
      expect(response).to have_http_status(:internal_server_error)
      ENV.delete('CATCH_EXCEPTION_DURING_TEST')
    end
  end
end
