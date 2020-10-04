# frozen_string_literal: true

FactoryBot.define do
  factory :store_model do
    store
    sequence(:name) { |n| "Model #{n}" }
    inventory { rand(0..100) }
  end
end
