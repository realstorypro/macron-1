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
                          :discussion_items,
                          :content_top_padding,
                          :content_icons,
                          :comment_count

    content_attr :menu_color, :string
    content_attr :overlay_color, :string
    content_attr :overlay_background, :string
    content_attr :image_style, :string
    content_attr :category_style, :string
    content_attr :item_order, :string
    content_attr :featured_items, :integer
    content_attr :discussion_items, :integer
    content_attr :content_top_padding, :integer
    content_attr :content_icons, :string
    content_attr :comment_count, :string

    def self.instance
      Homepage.first_or_create! do |settings|
        settings.menu_color = "black"
        settings.overlay_color = "black"
        settings.overlay_background = "normal"
        settings.image_style = "normal"
        settings.category_style = "normal"
        settings.item_order = "auto"
        settings.featured_items = "5"
        settings.discussion_items = 6
        settings.content_top_padding = 1
        settings.content_icons = "show"
        settings.comment_count = "hide"
      end
    end

  end
end
