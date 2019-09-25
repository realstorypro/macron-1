# frozen_string_literal: true

module Entries
  class Article < Entry
    include Autoloadable
    include Activitible

    validates_presence_of :category
    paginates_per 5
  end
end
