# frozen_string_literal: true

class Color < ApplicationRecord
  validates :name, presence: true
  has_many :categories
end
