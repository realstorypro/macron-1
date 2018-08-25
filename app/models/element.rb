# frozen_string_literal: true

class Element < ApplicationRecord
  include Payloadable

  belongs_to :elementable, polymorphic: true, optional: true
  has_many :elements, -> { order(:position) }, as: :elementable

  belongs_to :page, optional: true

  def self.policy_class
    MetaPolicy
  end
end
