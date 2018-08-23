# frozen_string_literal: true

class PageElement < ApplicationRecord
  belongs_to :page
  belongs_to :element
end