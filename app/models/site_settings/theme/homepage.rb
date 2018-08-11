# frozen_string_literal: true

module SiteSettings::Theme
  class Homepage < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Homepage.exists?
    end


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
