module SiteSettings::Theme
  class Homepage < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Homepage.exists?
    end

    validates_presence_of :menu_color, :overlay_color,
                          :overlay_background,
                          :category_style,
                          :item_order,
                          :featured_items,
                          :featured_variant,
                          :discussion_items,
                          :content_top_padding

    content_attr :menu_color, :string
    content_attr :overlay_color, :string
    content_attr :overlay_background, :string
    content_attr :category_style, :string
    content_attr :item_order, :string
    content_attr :featured_items, :integer
    content_attr :featured_variant, :string
    content_attr :discussion_items, :integer
    content_attr :content_top_padding, :integer

    def self.instance
      Homepage.first_or_create! do |settings|
        settings.menu_color = "black"
        settings.overlay_color = "black"
        settings.overlay_background = "normal"
        settings.category_style = "normal"
        settings.item_order = "auto"
        settings.featured_items = "5"
        settings.featured_variant = "a"
        settings.discussion_items = 6
        settings.content_top_padding = 1
      end
    end

  end
end
