# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, presence: true
  has_many :taggings

  has_many :discussions, through: :taggings, source: :taggable, source_type: "Discussion"
  has_many :articles, through: :taggings, source: :taggable, source_type: "Article"
  has_many :promotions, through: :taggings, source: :taggable, source_type: "Promotion"

  def self.policy_class
    MetaPolicy
  end
end
