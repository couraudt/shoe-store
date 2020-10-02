# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    sequence(:name) { |n| "Store #{n}" }

    trait :with_models do
      models { [association(:store_model)] }
    end
  end
end
