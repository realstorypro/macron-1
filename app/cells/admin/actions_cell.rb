module Admin
  class ActionsCell < Cell::ViewModel
    include ApplicationHelper
    include DcUi::Helpers

    # Options
    # 'show:' as ['buttons', 'dropdown'] the rendering style
    # 'icons: true' shows the icons
    # 'icon_position:' as [':left', ':right'] - where the icon sits
    # 'labeled: true' makes the button a labeled button

    def show
      case options[:show]
      when :buttons then render "buttons"
      when :dropdown then render "dropdown"
      end
    end

    def actions
      options[:actions]
    end

    # are the icons enabled
    def icons?
      options[:icons]
    end

    # is the button labeled
    def labeled?
      options[:labeled]
    end

    # returns the icons position
    def icon_position
      # defaults return to left unless we explicitly pass icon position
      return :left unless options[:icon_position]
      options[:icon_position]
    end

    private

      def build_button_class(base_class)
        base_class ||= ""
        base_class << (" " + icon_position.to_s + " labeled icon") if labeled?
        base_class
      end
  end
end
