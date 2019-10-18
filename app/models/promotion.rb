# frozen_string_literal: true

class Promotion < Entry
  include Autoloadable
  include Taggable
  validates :url, url: true
end
