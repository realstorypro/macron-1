# frozen_string_literal: true

class Promotion < Entry
  include Autoloadable
  validates :url, url: true
end
