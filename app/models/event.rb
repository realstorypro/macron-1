# frozen_string_literal: true

class Event < Entry
  include Autoloadable

  validates_presence_of :category
  validates :ticket_link, url: true

  paginates_per 5
end
