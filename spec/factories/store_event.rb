# frozen_string_literal: true

FactoryBot.define do
  factory :store_event do
    store
    store_model
    inventory { rand(0..100) }
  end
end
