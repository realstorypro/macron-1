# frozen_string_literal: true

class Element < ApplicationRecord
  include Payloadable

  belongs_to :elementable, polymorphic: true, optional: true, touch: true
  has_many :elements, -> { order(:position) }, as: :elementable, dependent: :destroy

  def self.policy_class
    MetaPolicy
  end
end
