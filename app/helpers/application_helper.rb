# frozen_string_literal: true

module ApplicationHelper
  include SettingsHelper
  include PathHelper
  include UserHelper
  include CrudHelper
  include ImageHelper

  def menu_color_class
    if controller_name == 'page' && action_name.downcase == 'home'
      ss('homepage_menu_color')
    else
      ss('menu_color')
    end
  end
end
