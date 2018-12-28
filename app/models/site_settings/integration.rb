# frozen_string_literal: true

module SiteSettings
  class Integration < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Integration.exists?
    end

    validates :newsletter_webhook, url: { schemes: ["https"] }, on: :update

    def self.instance
      Integration.first_or_create!
    end
  end
end
