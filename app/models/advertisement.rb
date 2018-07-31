# frozen_string_literal: true

class Advertisement < Entry
  include Autoloadable
  validates :url, url: true
end
