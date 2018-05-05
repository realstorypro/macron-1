# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, presence: true
  has_many :taggings

  has_many :discussions, through: :taggings, source: :taggable, source_type: "Discussion"
  has_many :articles, through: :taggings, source: :taggable, source_type: "Article"
  has_many :advertisements, through: :taggings, source: :taggable, source_type: "Advertisement"

  def self.policy_class
    MetaPolicy
  end
end
