# frozen_string_literal: true

json.cache! model do
  json.call(model, :id, :store_id, :name, :inventory)
end
