# frozen_string_literal: true

module ApplicationHelper
  include SettingsHelper
  include PathHelper
  include UserHelper
  include CrudHelper
  include ImageHelper

  def menu_color_class
    if controller_name == "page" && action_name.downcase == "home"
      ss("homepage_menu_color")
    elsif controller_name == "discussions" && action_name.downcase == "show"
      contrast = determine_contrast(@entry.category.color.name)

      "#{contrast} #{ss('menu_color')}"
    else
      ss("menu_color")
    end
  end

  def determine_contrast(color)
    inverted_colors = %w(red blue olive green teal purple pink brown black)
    if inverted_colors.include?(color)
      'inverted'
    else
      'regular'
    end
  end
end
