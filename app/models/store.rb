# frozen_string_literal: true

class Store < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
