# frozen_string_literal: true

module SiteSettings::Theme
  class Global < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Global.exists?
    end

    def self.instance
      Global.first_or_create! do |settings|
        settings.header_font = "Relevay"
        settings.body_font = "Roboto"

        settings.overlay_background = "auto"
      end
    end
  end
end
