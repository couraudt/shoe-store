# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :models, class_name: 'StoreModel', dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
