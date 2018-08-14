# frozen_string_literal: true

module SiteSettings
  class Integration < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Integration.exists?
    end

    validates :newsletter_webhook, url: { schemes: ["https"] }

    def self.instance
      Integration.first_or_create! do |settings|
        settings.newsletter_webhook = "https://hooks.zapier.com/hooks/catch/3200901/fsym7e/"
        # initializing as blank keys
        settings.segment_js_key = ""
        settings.segment_server_key = ""
        settings.shopify_domain = ""
        settings.shopify_buy_token = ""
      end
    end
  end
end
