# frozen_string_literal: true

module ApplicationHelper
  include SettingsHelper
  include PathHelper
  include UserHelper
  include CrudHelper
  include ImageHelper

  def menu_color_class
    # apply homepage menu color if we're on the homepage
    if controller_name == "page" && action_name.downcase == "home"
      ss("homepage_menu_color")

    elsif controller_name == "page" && action_name.downcase != "home"
      # we want the bordered class applied on pages that are not home

      menu_color = ss("menu_color")
      border = "bordered"
      "#{menu_color} #{border}"

    elsif controller_name == "discussions" && action_name.downcase == "show"
      # if we're on discussion with a white categories we want to apply bordered class

      category_color = @entry.category.color.name
      contrast = determine_contrast(category_color)
      menu_color = ss("menu_color")
      "#{contrast} #{menu_color} #{'bordered' if category_color == 'white'}"

    else
      # otherwise apply menu color

      ss("menu_color")
    end
  end

  def determine_contrast(color)
    inverted_colors = %w(red blue olive green teal purple pink brown black)
    if inverted_colors.include?(color)
      "inverted"
    else
      "regular"
    end
  end

  def reversed_class(order)
    "computer reversed" if order == "reversed"
  end
end
