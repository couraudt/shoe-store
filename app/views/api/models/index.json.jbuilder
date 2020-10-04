# frozen_string_literal: true

json.cache! @models do
  json.array! @models, partial: 'api/models/model', as: :model
end
