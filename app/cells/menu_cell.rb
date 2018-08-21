# TODO :: Factor Out into navigation cell

class MenuCell < BaseCell
  def show
    render
  end

  private

    # renders menu item
    def render_menu_item(menu_item)
      # short circuits rendering unless the menu is enabled
      return unless menu_item[:enabled]

      menu_link menu_item[:name], menu_item[:path], menu_item[:icon], menu_item[:turbolinks]
    end

    # renders menu link
    def menu_link(name, path, menu_icon, turbolinks)
      # variable to store the link class
      # adding a default of 'item' per semantic-ui
      # https://semantic-ui.com/collections/menu.html
      link_class = "item"

      # do not generate the link_path from menu if the link is an actual link
      link_path = menu_path(path) unless path.include?("/")

      # treat the path as an actual link
      link_path = path if path.include?("/")

      if active_path?(link_path)
        # toggle menu icon to active if the path is active
        menu_icon = active_icon

        # add active link class
        link_class << " active"
      end

      link_text = menu_text(name, menu_icon)
      if turbolinks == false
        link_to link_text, link_path, class: link_class, 'data-turbolinks': "false"
      else
        link_to link_text, link_path, class: link_class
      end
    end

    # renders text to be used inside of the menu
    def menu_text(name, menu_icon)
      raw("#{icon(menu_icon) if show_icons?} #{name}")
    end

    # returns a formatted link path
    def menu_path(path)
      url_helpers.send(path + "_path")
    end

    # checks if the path is active
    def active_path?(path)
      # the root path is never active, because it returns to the main app
      return false if always_inactive.include? path
      return false unless path.nil? || request.env["PATH_INFO"].include?(path)
      true
    end

    # returns true if the section is empty
    def empty_section? (section)
      return true unless section.any? { |menu_item| options[:policy].index?(menu_item[:component]) }
    end

    ################################
    ###### Argument Shortcuts ######
    ################################

    # shortcut for accessing menu sections
    def sections
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

    # shortcut for accessing 'always active' items
    def always_inactive
      %w[/]
    end

    # toggles showing icons
    def show_icons?
      return false unless options[:show_icons]
      true
    end


    def show_divider?
      return false unless options[:show_divider]
      true
    end
end
