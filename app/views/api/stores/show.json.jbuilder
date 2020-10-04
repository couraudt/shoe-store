# frozen_string_literal: true

json.cache! @store do
  json.partial! 'api/stores/store', store: @store
end
