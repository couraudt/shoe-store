# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    sequence(:name) { |n| "Store #{n}" }

    trait :with_models do
      after(:create) do |store|
        create(:store_model, store: store)
      end
    end
  end
end
