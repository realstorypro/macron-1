# frozen_string_literal: true

module SiteSettings
  class Theme < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Theme.exists?
    end


    content_attr :content_icons, :string
    content_attr :comment_count, :string

    content_attr :homepage_featured_items, :integer
    content_attr :homepage_discussion_items, :integer
    content_attr :homepage_menu_color, :string
    content_attr :homepage_content_top_padding, :integer

    content_attr :menu_color, :string
    content_attr :menu_position, :string
    content_attr :desktop_logo_size, :integer
    content_attr :mobile_logo_size, :integer

    content_attr :footer_color, :string
    content_attr :about, :text
    content_attr :copyrights, :string

    content_attr :sign_up_title, :string
    content_attr :sign_up_subtitle, :string
    content_attr :sign_in_title, :string

    # TODO: populate defaults & requirements
    def self.instance
      Theme.first_or_create! do |settings|
        settings.content_icons = 'show'
        settings.comment_count = 'hide'

        settings.homepage_featured_items = 'auto'
        settings.homepage_discussion_items = 6
        settings.homepage_menu_color = 'black'
        settings.homepage_content_top_padding = 1

        settings.menu_color = "black"
        settings.menu_position = "left"
        settings.desktop_logo_size = 150
        settings.mobile_logo_size = 120

        settings.footer_color = "black"
        settings.about = "about section"
        settings.copyrights = "2017 - 2018 IdeaLogic"

        settings.sign_up_title = "Sign Up"
        settings.sign_up_subtitle = "Join The Community"
        settings.sign_in_title = "Sign In"
      end
    end
  end
end
