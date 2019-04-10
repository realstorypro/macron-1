# frozen_string_literal: true

module VueHelper

  # the name should be space separated
  # loads vue widget
  def vue_widget(options)
    Vue::WidgetCell.(nil, options)
  end
end
