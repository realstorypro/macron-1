module SiteSettings::Theme
  class General < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if General.exists?
    end

    validates_presence_of :header_font,
                          :body_font,

                          :menu_color,
                          :menu_position,

                          :footer_variant,
                          :footer_color,
                          :footer_icon,
                          :footer_button_color,
                          :footer_button_style,
                          :footer_item_order,

                          :overlay_background

    content_attr :header_font, :string
    content_attr :body_font, :string

    content_attr :menu_color, :string
    content_attr :menu_position, :string

    content_attr :footer_variant, :string
    content_attr :footer_color, :string
    content_attr :footer_icon, :string
    content_attr :footer_button_color, :string
    content_attr :footer_button_style, :string
    content_attr :footer_item_order, :string

    content_attr :overlay_background, :string

    def self.instance
      General.first_or_create! do |settings|
        settings.header_font = "Relevay"
        settings.body_font = "Roboto"

        settings.menu_color = "black"
        settings.menu_position = "left"
        
        settings.footer_variant = "full"
        settings.footer_color = "black"
        settings.footer_icon = "show"
        settings.footer_button_color = "white"
        settings.footer_button_style = "regular"
        settings.footer_item_order = "auto"

        settings.overlay_background = "auto"
      end
    end

  end
end
