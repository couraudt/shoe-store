# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :models, class_name: 'StoreModel', dependent: :destroy
  has_many :events, class_name: 'StoreEvent', dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
