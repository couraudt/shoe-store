# frozen_string_literal: true

class StoreModel < ApplicationRecord
  belongs_to :store, counter_cache: :models_count

  validates :store, presence: true
  validates :name, uniqueness: { scope: :store, case_sensitive: false }, presence: true
end
