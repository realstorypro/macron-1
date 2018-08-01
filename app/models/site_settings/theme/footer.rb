# frozen_string_literal: true

module SiteSettings::Theme
  class Footer < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Footer.exists?
    end

    def self.instance
      Footer.first_or_create! do |settings|
        settings.color = "black"
        settings.icon = "show"
        settings.button_color = "white"
        settings.button_style = "regular"
        settings.item_order = "auto"

        settings.about = "<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, \
                          sed diam nonumy eirmod tempor invidunt ut\
                          labore et dolore magna aliquyam erat, sed diam voluptua.</p>\
                          <p>Lorem ipsum dolor sit amet, \
                          consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut \
                          labore et dolore magna aliquyam erat,\
                          sed diam voluptua.</p>"
        settings.copyrights = "2017 - 2018 ideaLogic"
      end
    end
  end
end
