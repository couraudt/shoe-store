# frozen_string_literal: true

json.cache! @model do
  json.partial! 'api/models/model', model: @model
end
