# frozen_string_literal: true

class Color < ApplicationRecord
  validates :name, presence: true
  has_many :categories

  # we don't want white to be pulled in by default
  default_scope -> { where.not(name: 'white')}
end
