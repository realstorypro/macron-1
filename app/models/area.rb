# frozen_string_literal: true

class Area < ApplicationRecord
  belongs_to :areable, polymorphic: true, optional: true, touch: true

  has_many :elements, -> { order(:position) }, as: :elementable, dependent: :destroy

  def self.policy_class
    MetaPolicy
  end
end
