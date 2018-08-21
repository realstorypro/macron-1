module Navigation
  class NavigationCell < BaseCell
    include Devise::Controllers::Helpers

    def show
      render
    end

    private

      # checks if the menu item should be shown
      def show_item?(menu_item)
        # short circuits rendering unless the menu is enabled
        return false unless menu_item[:enabled]

        # hide advanced menu items unless user is in advancd mdoe
        return false if menu_item[:advanced] && !current_user.advanced

        return true if menu_item[:component] && options[:policy].index?(menu_item[:component])
        return true if menu_item[:component].nil?
        false
      end

      def link_path(path)
        # this is a regular path
        if path.include?("/")
         path
        else
          url_helpers.send(path + "_path")
        end
      end

      # checks if the path is active
      def active_path?(path)
        # get the actual link
        path = link_path(path)

        # the root path is never active, because it returns to the main app
        return false if %w[/].include? path
        return false unless path.nil? || request.env["PATH_INFO"].include?(path)
        true
      end

      def show_divider?(section_array)
        return false unless options[:show_divider]
        return false unless section_array.any? { |menu_item| options[:policy].index?(menu_item[:component]) }
        true
      end

      def show_icons?
        return false unless options[:show_icons]
        true
      end


      ################################
      ###### Argument Shortcuts ######
      ################################

      # shortcut for accessing menu sections
      def menu
        options[:menu]
      end

      # shortcut for accessing request variables
      def request
        options[:request]
      end

      # shortcut for accessing menu's active icon
      def active_icon
        options[:active_icon]
      end

      # shortcut for accessing policy
      def policy
        options[:policy]
      end
  end
end
