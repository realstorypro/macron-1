# frozen_string_literal: true

class Discussion < Entry
  include Autoloadable
  include Trackable

  validates_presence_of :category
  paginates_per 25
end
