# frozen_string_literal: true

module MenuHelper
  include ColorHelper
  def menu_color_class
    transparent_controllers = %w(articles videos)

    # in case of homepage apply the homepage colors
    if controller_name == "page" && action_name.downcase == "home"
      menu_color = ss("homepage_menu_color")
      render_menu_class(menu_color)

    # all other pages & exception pages
    elsif (controller_name == "page" && action_name.downcase != "home") || (controller_name == "exceptions")
      menu_color = ss("menu_color")

      if menu_color == 'white'
        render_menu_class(menu_color, bordered: true)
      else
        render_menu_class(menu_color)
      end

    elsif controller_name == "discussions" && action_name.downcase == "show"
      # if we're on discussion with a white categories we want to apply bordered class
      menu_color = ss("menu_color")
      category_color = @entry.category.color.name
      if category_color == 'white'
        render_menu_class(category_color, bordered: true, transparent: true)
      else
        render_menu_class(category_color, transparent: true)
      end
    elsif transparent_controllers.include?(controller_name) && action_name.downcase == "show"
      menu_color = ss("menu_color")
      render_menu_class(menu_color, imaged: true)
    else
      # otherwise apply menu color
      menu_color = ss("menu_color")
      render_menu_class(menu_color)
    end
  end

  private

  def render_menu_class(menu_color, options={})
    defaults = { bordered: false, transparent: false, imaged: false }
    options = defaults.merge(options)

    rendering =  ActiveSupport::SafeBuffer.new

    rendering << " imaged" if options[:imaged]
    rendering << " transparent" if options[:transparent]
    rendering << " bordered" if options[:bordered]
    rendering << " #{inverted?(menu_color)}"
    rendering << " #{menu_color}"
    rendering
  end
end
