# frozen_string_literal: true

module SiteSettings::Theme
  class Header < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Header.exists?
    end

    def self.instance
      Header.first_or_create! do |settings|
        settings.desktop_logo_size = 150
        settings.mobile_logo_size = 120

        settings.menu_color = "black"
        settings.button_color = "black"
        settings.menu_position = "left"
      end
    end
  end
end
