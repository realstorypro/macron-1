# frozen_string_literal: true

module SiteSettings
  class Branding < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Branding.exists?
    end

    content_attr :icon, :string
    content_attr :logo, :string
    content_attr :inverted_logo, :string
    content_attr :desktop_logo_size, :integer
    content_attr :mobile_logo_size, :integer
    content_attr :auth_background, :string

    validates_presence_of :logo, :inverted_logo

    def self.instance
      Branding.first_or_create! do |settings|
        settings.icon = "icon.png"
        settings.logo = "logo.png"
        settings.desktop_logo_size = 150
        settings.mobile_logo_size = 120
        settings.inverted_logo = "logo_inverted.png"
      end
    end
  end
end
