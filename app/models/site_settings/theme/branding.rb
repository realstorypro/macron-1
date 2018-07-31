# frozen_string_literal: true

module SiteSettings::Theme
  class Branding < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Branding.exists?
    end
    validates_presence_of :logo,
                          :inverted_logo,
                          :icon

    content_attr :logo, :string
    content_attr :inverted_logo, :string
    content_attr :icon, :string

    def self.instance
      Branding.first_or_create! do |settings|
        settings.logo = "logo.png"
        settings.inverted_logo = "logo_inverted.png"
        settings.icon = "icon.png"
      end
    end
  end
end
