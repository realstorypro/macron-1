
  module Widget
    class SidenavCell < Genesis::MenuCell
      include Devise::Controllers::Helpers

      def show
        render(options[:layout])
      end

      def menu_text(name, menu_icon)
        menu_icon << ' large' if menu_icon
        raw("#{icon(menu_icon) if show_icons?} #{name}")
      end

      # renders menu link
      def menu_link(name, path, menu_icon, _turbolinks)
        # variable to store the link class
        # adding a default of 'item' per semantic-ui
        # https://semantic-ui.com/collections/menu.html
        link_class = 'item large'
        link_path = menu_path(path)

        if active_path?(link_path)
          # toggle menu icon to active if the path is active
          menu_icon = active_icon

          # add active link class
          link_class << ' active'
        end

        link_text = menu_text(name, menu_icon)
        link_to link_text, link_path, class: link_class, 'v-on:click': "visit('#{link_path}')"
      end
    end
  end
