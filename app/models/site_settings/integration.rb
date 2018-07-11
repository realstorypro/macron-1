# frozen_string_literal: true

module SiteSettings
  class Integration < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Integration.exists?
    end

    content_attr :newsletter_webhook, :string
    content_attr :segment_js_key, :string
    content_attr :segment_server_key, :string

    validates :newsletter_webhook, url: { schemes: ["https"] }

    def self.instance
      Integration.first_or_create! do |settings|
        settings.newsletter_webhook = "https://hooks.zapier.com/hooks/catch/3200901/fsym7e/"
      end
    end
  end
end
