# frozen_string_literal: true

class Discussion < Entry
  include Autoloadable
  include Activitible

  validates_presence_of :category
  paginates_per 25
end
