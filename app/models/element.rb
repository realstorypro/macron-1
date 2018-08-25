# frozen_string_literal: true

class Element < ApplicationRecord
  include Payloadable

  has_one :page_element, dependent: :destroy
  has_one :page, through: :page_elements

  belongs_to :elementable, polymorphic: true
  has_many :elements, -> { order(:position) }, as: :elementable

  belongs_to :page

  def self.policy_class
    MetaPolicy
  end
end
