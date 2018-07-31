# frozen_string_literal: true

class Article < Entry
  include Autoloadable

  validates_presence_of :category

  paginates_per 5
end
