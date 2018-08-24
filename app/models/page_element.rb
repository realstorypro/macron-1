# frozen_string_literal: true

class PageElement < ApplicationRecord
  belongs_to :elementable, polymorphic: true
  has_many :page_elements, as: :elementable

  belongs_to :element
end
