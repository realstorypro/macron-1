# frozen_string_literal: true

module SiteSettings
  class Theme < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Theme.exists?
    end

    validates_presence_of :content_icons,
                          :comment_count,


                          :sign_up_title,
                          :sign_up_subtitle,
                          :sign_in_title


    # ** Migrating **
    content_attr :content_icons, :string
    content_attr :comment_count, :string

    content_attr :sign_up_title, :string
    content_attr :sign_up_subtitle, :string
    content_attr :sign_in_title, :string

    def self.instance
      Theme.first_or_create! do |settings|
        settings.content_icons = "show"
        settings.comment_count = "hide"




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
