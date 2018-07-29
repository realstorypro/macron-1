module SiteSettings::Theme
  class Footer < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Footer.exists?
    end

    validates_presence_of :footer_variant,
                          :footer_color,
                          :footer_icon,
                          :footer_button_color,
                          :footer_button_style,
                          :footer_item_order

    content_attr :footer_variant, :string
    content_attr :footer_color, :string
    content_attr :footer_icon, :string
    content_attr :footer_button_color, :string
    content_attr :footer_button_style, :string
    content_attr :footer_item_order, :string

    def self.instance
      Footer.first_or_create! do |settings|
        settings.footer_variant = "full"
        settings.footer_color = "black"
        settings.footer_icon = "show"
        settings.footer_button_color = "white"
        settings.footer_button_style = "regular"
        settings.footer_item_order = "auto"
      end
    end
  end
end
