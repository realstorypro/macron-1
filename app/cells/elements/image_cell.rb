# frozen_string_literal: true

module Elements
  class ImageCell < BaseElementCell
    def image_class
      css_class = "ui image"
      css_class = css_class + " #{model.size}" if model.size
      css_class = css_class + " #{model.alignment}" if model.alignment
      css_class = css_class + " #{model.style}" if model.style
      css_class
    end
  end
end
