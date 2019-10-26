# frozen_string_literal: true

class Element < ApplicationRecord
  include Payloadable

  belongs_to :elementable, polymorphic: true, optional: true, touch: true
  has_many :elements, -> { order(:position) }, as: :elementable, dependent: :destroy

  after_commit :set_sort

  def set_sort
    if self.elementable && position.nil?
      update_column 'position', self.elementable.elements.count
    end
  end

  def self.policy_class
    MetaPolicy
  end
end
