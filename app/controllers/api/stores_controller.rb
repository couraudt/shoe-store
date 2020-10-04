# frozen_string_literal: true

module Api
  class StoresController < BaseController
    before_action :find_store, only: %i[show]

    def index
      @stores = paginate(Store.includes(:models).all)
    end

    def show; end

    private

    def find_store
      @store = Store.includes(:models).find(params[:id])
    end
  end
end
