# frozen_string_literal: true

module NavHelper
  def menu_color_class
    transparent_controllers = %w(articles videos events store members profile)
    menu_color = ss("theme.header.menu_color")

    # in case of homepage apply the homepage colors
    if controller_name == "page" && action_name.downcase == "home"
      homepage_menu_color = ss("theme.homepage.menu_color")

      menu_class(expanded_color: homepage_menu_color, collapsed_color: menu_color)

    # all other pages & exception pages
    elsif (controller_name == "page" && action_name.downcase != "home") || (controller_name == "exceptions")
      if menu_color == "white"
        menu_class(expanded_color: menu_color, collapsed_color: menu_color, bordered: true)
      else
        menu_class(expanded_color: menu_color, collapsed_color: menu_color)
      end

    elsif controller_name == "discussions" && action_name.downcase == "show"
      menu_style = ss("theme.discussion.menu_style")
      category_color = @entry.category.color.name

      # we want to eliminate transparency if the background is set as solid
      # we only want to show the border if both category and menu colors are white
      if menu_style == "solid"
        if category_color == "white" && menu_color == "white"
          menu_class(expanded_color: menu_color, collapsed_color: menu_color, bordered: true, transparent: false)
        else
          menu_class(expanded_color: menu_color, collapsed_color: menu_color, transparent: false)
        end
      elsif menu_style == "matching solid"
        if category_color == "white" && menu_color == "white"
          menu_class(expanded_color: menu_color, collapsed_color: category_color, bordered: true, transparent: false)
        else
          menu_class(expanded_color: menu_color, collapsed_color: category_color, transparent: false)
        end

      elsif menu_style == "transparent"
        if category_color == "white"
          menu_class(expanded_color: category_color, collapsed_color: menu_color, bordered: true, transparent: true)
        else
          menu_class(expanded_color: category_color, collapsed_color: menu_color, transparent: true)
        end
      elsif menu_style == "matching transparent"
        if category_color == "white"
          menu_class(expanded_color: category_color, collapsed_color: category_color, bordered: true, transparent: true)
        else
          menu_class(expanded_color: category_color, collapsed_color: category_color, transparent: true)
        end
      end
    elsif %w[sessions registrations passwords confirmations].include?(controller_name)
      # auth fullscreen image option
      # we want to have an inverted logo that's why we're passing the *expanded_color: black*
      menu_class(transparent: true, expanded_color: "black", collapsed_color: menu_color)
    elsif transparent_controllers.include?(controller_name) && action_name.downcase == "show"
      # fullscreen image option
      # we want to have an inverted logo that's why we're passing the *expanded_color: black*
      menu_class(transparent: true, expanded_color: "black", collapsed_color: menu_color)
    else
      # apply menu color if nothign is there
      menu_class(expanded_color: menu_color, collapsed_color: menu_color)
    end
  end

  private

    def menu_class(options = {})
      defaults = { expanded_color: "black", collapsed_color: "black", bordered: false }
      options = defaults.merge(options)

      rendering = ActiveSupport::SafeBuffer.new

      expanded_class = determine_class(style: "expanded",
                                       color: options[:expanded_color],
                                       bordered: options[:bordered],
                                       transparent: options[:transparent]
      )
      collapsed_class = determine_class(style: "collapsed", color: options[:collapsed_color])

      rendering << expanded_class
      rendering << " "
      rendering << collapsed_class
      rendering << " bordered" if options[:bordered]
      rendering
    end

    # note: the order of classes matters see navigation.sass to understand why
    def determine_class(options)
      palette = Palette.new

      defaults = {
          transparent: false,
          inverted: false,
          color: "",
          style: "expanded"
      }
      options = defaults.merge(options)

      rendering = ActiveSupport::SafeBuffer.new

      # we want to force color inversion if it is specified
      # otherwise we'll default to class color
      rendering << "#{palette.contrast(options[:color])}"
      rendering << " #{options[:style]} "
      rendering << options[:color] unless options[:transparent]
      rendering
    end
end
