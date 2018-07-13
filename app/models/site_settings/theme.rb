# frozen_string_literal: true

module SiteSettings
  class Theme < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Theme.exists?
    end


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
        settings.homepage_featured_items = 2
        settings.homepage_discussion_items = 6
        settings.menu_position = 'left'
        settings.menu_color = 'black'
        settings.footer_color = 'black'
        settings.about = "about section"
        settings.copyrights = "2017 - 2018 IdeaLogic"
      end
    end
  end
end
