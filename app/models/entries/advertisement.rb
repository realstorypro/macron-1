# frozen_string_literal: true

module Entries
  class Advertisement < Entry
    include Autoloadable
    validates :url, url: true
  end
end
