# frozen_string_literal: true

module MenuHelper
  include ColorHelper
  def menu_color_class
    transparent_controllers = %w(articles videos)

    # in case of homepage apply the homepage colors
    if controller_name == "page" && action_name.downcase == "home"
      homepage_menu_color = ss("homepage_menu_color")
      menu_color = ss("menu_color")

      render_menu_class(expanded_color: homepage_menu_color, collapsed_color: menu_color)

    # all other pages & exception pages
    elsif (controller_name == "page" && action_name.downcase != "home") || (controller_name == "exceptions")
      menu_color = ss("menu_color")

      if menu_color == "white"
        render_menu_class(expanded_color: menu_color, collapsed_color: menu_color, bordered: true)
      else
        render_menu_class(expanded_color: menu_color, collapsed_color: menu_color)
      end

    elsif controller_name == "discussions" && action_name.downcase == "show"
      # if we're on discussion with a white categories we want to apply bordered class
      menu_color = ss("menu_color")
      menu_style = ss(:discussion_menu_style)
      category_color = @entry.category.color.name

      return render_menu_class(menu_color) if menu_style == "solid"

      if category_color == "white"
        render_menu_class(expanded_color: category_color, collapsed_color: menu_color, bordered: true, transparent: true)
      else
        render_menu_class(expanded_color: category_color, collapsed_color: menu_color, transparent: true)
      end

    elsif transparent_controllers.include?(controller_name) && action_name.downcase == "show"
      menu_color = ss("menu_color")

      # we're passing expanded color to black to force the inverted logo
      render_menu_class(transparent: true, expanded_color: "black", collapsed_color: menu_color)
    else
      # apply menu color if nothign is there
      menu_color = ss("menu_color")
      render_menu_class(menu_color)
    end
  end

  private

  def render_menu_class(options={})
    defaults = { expanded_color: "black", collapsed_color: "black", bordered: false }
    options = defaults.merge(options)

    rendering =  ActiveSupport::SafeBuffer.new

    rendering << determine_class(style: "expanded", color: options[:expanded_color], bordered: options[:bordered], transparent: options[:transparent])
    rendering << " "
    rendering << determine_class(style: "collapsed", color: options[:collapsed_color])
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

  def collapsed_class

  end

end
