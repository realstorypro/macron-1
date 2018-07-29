module SiteSettings::Theme
  class Header < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Header.exists?
    end

    validates_presence_of :logo,
                          :inverted_logo,
                          :menu_color,
                          :menu_position

    content_attr :desktop_logo_size, :integer
    content_attr :mobile_logo_size, :integer

    content_attr :menu_color, :string
    content_attr :menu_position, :string

    def self.instance
      Header.first_or_create! do |settings|
        settings.desktop_logo_size = 150
        settings.mobile_logo_size = 120

        settings.menu_color = "black"
        settings.menu_position = "left"
      end
    end
  end
end
