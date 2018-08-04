# frozen_string_literal: true

module SiteSettings::Theme
  class Authentication < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Authentication.exists?
    end

    def self.instance
      Authentication.first_or_create! do |settings|
        settings.sign_up_title = "Sign Up"
        settings.sign_up_subtitle = "Join The Community"
        settings.sign_in_title = "Sign In"
        settings.auth_background = "logo.png"
      end
    end
  end
end
