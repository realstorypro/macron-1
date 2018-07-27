module SiteSettings::Theme
  class General < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if General.exists?
    end

    validates_presence_of :header_font,
                          :body_font,
                          :overlay_background

    content_attr :header_font, :string
    content_attr :body_font, :string
    content_attr :overlay_background, :string

    def self.instance
      General.first_or_create! do |settings|
        settings.header_font = "Relevay"
        settings.body_font = "Roboto"
        settings.overlay_background = "auto"
      end
    end

  end
end
