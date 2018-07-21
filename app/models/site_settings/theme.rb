# frozen_string_literal: true

module SiteSettings
  class Theme < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Theme.exists?
    end

    validates_presence_of :header_font,
                          :body_font,
                          :content_icons,
                          :comment_count, :overlay_background,
                          :homepage_menu_color, :homepage_overlay_color,
                          :homepage_overlay_background,
                          :homepage_category_style,
                          :homepage_item_order,
                          :homepage_featured_items,
                          :homepage_featured_variant,
                          :homepage_discussion_items,
                          :homepage_content_top_padding,
                          :menu_color,
                          :menu_position,
                          :desktop_logo_size,
                          :mobile_logo_size,
                          :footer_variant,
                          :footer_color,
                          :footer_icon,
                          :footer_button_color,
                          :footer_button_style,
                          :footer_item_order,
                          :about,
                          :copyrights,
                          :sign_up_title,
                          :sign_up_subtitle,
                          :sign_in_title


    content_attr :header_font, :string
    content_attr :body_font, :string

    content_attr :content_icons, :string
    content_attr :comment_count, :string
    content_attr :overlay_background, :string

    content_attr :homepage_menu_color, :string
    content_attr :homepage_overlay_color, :string
    content_attr :homepage_overlay_background, :string
    content_attr :homepage_category_style, :string
    content_attr :homepage_item_order, :string
    content_attr :homepage_featured_items, :integer
    content_attr :homepage_featured_variant, :string
    content_attr :homepage_discussion_items, :integer
    content_attr :homepage_content_top_padding, :integer

    content_attr :menu_color, :string
    content_attr :menu_position, :string
    content_attr :desktop_logo_size, :integer
    content_attr :mobile_logo_size, :integer

    content_attr :footer_variant, :string
    content_attr :footer_color, :string
    content_attr :footer_icon, :string
    content_attr :footer_button_color, :string
    content_attr :footer_button_style, :string
    content_attr :footer_item_order, :string

    content_attr :about, :text
    content_attr :copyrights, :string

    content_attr :sign_up_title, :string
    content_attr :sign_up_subtitle, :string
    content_attr :sign_in_title, :string

    def self.instance
      Theme.first_or_create! do |settings|
        settings.header_font = "Relevay"
        settings.body_font = "Roboto"

        settings.content_icons = "show"
        settings.comment_count = "hide"
        settings.overlay_background = "auto"

        settings.homepage_menu_color = "black"
        settings.homepage_overlay_color = "black"
        settings.homepage_overlay_background = "normal"
        settings.homepage_category_style = "normal"
        settings.homepage_item_order = "auto"
        settings.homepage_featured_items = "5"
        settings.homepage_featured_variant = "a"
        settings.homepage_discussion_items = 6
        settings.homepage_content_top_padding = 1

        settings.menu_color = "black"
        settings.menu_position = "left"
        settings.desktop_logo_size = 150
        settings.mobile_logo_size = 120

        settings.footer_variant = "full"
        settings.footer_color = "black"
        settings.footer_icon = "show"
        settings.footer_button_color = "white"
        settings.footer_button_style = "regular"
        settings.footer_item_order = "auto"

        settings.about = "<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, \
                          sed diam nonumy eirmod tempor invidunt ut\
                          labore et dolore magna aliquyam erat, sed diam voluptua.</p>\
                          <p>Lorem ipsum dolor sit amet, \
                          consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut \
                          labore et dolore magna aliquyam erat,\
                          sed diam voluptua.</p>"
        settings.copyrights = "2017 - 2018 IdeaLogic"

        settings.sign_up_title = "Sign Up"
        settings.sign_up_subtitle = "Join The Community"
        settings.sign_in_title = "Sign In"
      end
    end
  end
end
