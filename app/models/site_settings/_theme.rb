# frozen_string_literal: true

module SiteSettings
  class Theme < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Theme.exists?
    end

    validates_presence_of :content_icons,
                          :comment_count


    content_attr :content_icons, :string
    content_attr :comment_count, :string


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

      end
    end
  end
end
