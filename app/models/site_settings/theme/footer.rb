module SiteSettings::Theme
  class Footer < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Footer.exists?
    end

    validates_presence_of :footer_color,
                          :footer_icon,
                          :footer_button_color,
                          :footer_button_style,
                          :footer_item_order,
                          :about,
                          :copyrights

    content_attr :footer_color, :string
    content_attr :footer_icon, :string
    content_attr :footer_button_color, :string
    content_attr :footer_button_style, :string
    content_attr :footer_item_order, :string

    content_attr :about, :text
    content_attr :copyrights, :string

    def self.instance
      Footer.first_or_create! do |settings|
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
        settings.copyrights = "2017 - 2018 ideaLogic"
      end
    end
  end
end
