# frozen_string_literal: true

module SiteSettings
  class Integration < Setting
    include Autoloadable
    validates :newsletter_webhook, url: { schemes: ["https"] }, on: :update
  end
end
