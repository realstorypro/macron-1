# frozen_string_literal: true

module ColorHelper
  def get_color_value(color_name)
    palette = Palette.new
    "##{palette.color_value(color_name)}"
  end
end
