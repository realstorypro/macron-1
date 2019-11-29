# frozen_string_literal: true

module VueHelper
  # the name should be space separated
  # loads vue widget
  def vue_widget(options)
    options[:current_user] = current_user if current_user
    options[:site_settings] = @site_settings
    Vue::WidgetCell.(nil, options)
  end
end
