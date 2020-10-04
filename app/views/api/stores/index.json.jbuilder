# frozen_string_literal: true

json.cache! @stores do
  json.array! @stores, partial: 'api/stores/store', as: :store
end
