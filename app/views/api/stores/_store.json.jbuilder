# frozen_string_literal: true

json.cache! store do
  json.call(store, :id, :name, :models_count)
end
json.cache! store.models do
  json.models store.models, partial: 'api/models/model', as: :model
end
