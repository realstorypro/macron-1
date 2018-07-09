module SiteSettings
  class Branding < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Branding.exists?
    end

    content_attr :logo, :string
    content_attr :inverted_logo, :string
    content_attr :desktop_logo_size, :integer
    content_attr :mobile_logo_size, :integer

    content_attr :favicon_16, :string
    content_attr :favicon_32, :string
    content_attr :favicon_96, :string
    content_attr :favicon_120, :string
    content_attr :favicon_152, :string
    content_attr :favicon_167, :string
    content_attr :favicon_180, :string
    content_attr :auth_background, :string

    validates_presence_of :logo, :inverted_logo

    def self.instance
      Branding.first_or_create! do |settings|
        settings.logo = "logo.png"
        settings.inverted_logo = "logo_inverted.png"
      end
    end

  end
end
