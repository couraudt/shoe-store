# frozen_string_literal: true

module Api
  class ModelsController < BaseController
    before_action :find_model, only: %i[show]

    def index
      @models = paginate(StoreModel.all)
    end

    def show; end

    private

    def find_model
      @model = Store.find(params[:store_id]).models.find(params[:id])
    end
  end
end
