# frozen_string_literal: true

class Element < ApplicationRecord
  include Payloadable

  has_one :page_element
  has_one :page, through: :page_elements

  def self.policy_class
    MetaPolicy
  end
end
