# frozen_string_literal: true

module SiteSettings
  class General < Setting
    include Autoloadable
    validates :url, url: { schemes: ["https"] }, on: :update
  end
end
