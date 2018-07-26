# frozen_string_literal: true

module MenuHelper
  include ColorHelper
  def menu_color_class
    transparent_controllers = %w(articles videos)
    menu_color = ss("menu_color")

    # in case of homepage apply the homepage colors
    if controller_name == "page" && action_name.downcase == "home"
      homepage_menu_color = ss("homepage_menu_color")

      menu_class(expanded_color: homepage_menu_color, collapsed_color: menu_color)

    # all other pages & exception pages
    elsif (controller_name == "page" && action_name.downcase != "home") || (controller_name == "exceptions")
      if menu_color == "white"
        menu_class(expanded_color: menu_color, collapsed_color: menu_color, bordered: true)
      else
        menu_class(expanded_color: menu_color, collapsed_color: menu_color)
      end

    elsif controller_name == "discussions" && action_name.downcase == "show"
      menu_style = ss(:discussion_menu_style)
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
    elsif %w[members profile].include?(controller_name)
      color = @entry.menu_color
      color = "black" if color.nil?
      menu_class(transparent: false , expanded_color: color, collapsed_color: menu_color)
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
      defaults = {
          transparent: false,
          inverted: false,
          color: "",
          style: "expanded"
      }
      options = defaults.merge(options)

      output =  ActiveSupport::SafeBuffer.new

      # we want to force color inversion if it is specified
      # otherwise we'll default to class color
      output << inverted?(options[:color])
      output << " #{options[:style]} "
      output << options[:color] unless options[:transparent]
      output
    end
end
