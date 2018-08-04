# frozen_string_literal: true

class Palette
  attr_accessor :colors, :regular, :inverted

  def initialize(options = {})
    defaults = {
        colors: %w(red orange yellow olive green teal blue violet purple pink brown grey black white ),
        inverted: %w(red blue olive green teal purple pink brown black),
        color_map: {
          red: "B03060",
          orange: "FF8243",
          yellow: "FFD700",
          olive: "32CD32",
          green: "21BA45",
          teal: "008080",
          blue: "2185D0",
          violet: "EE82EE",
          purple: "B413EC",
          pink: "FF1493",
          brown: "A52A2A",
          grey: "A0A0A0",
          black: "666666",
          white: "000000"
        }
    }
    options = defaults.merge(options)

    @colors = options[:colors]
    @inverted = options[:inverted]
    @color_map = options[:color_map]
  end

  # retruns whether the color is regular or inverted
  def contrast(color)
    if @inverted.include?(color)
      "inverted"
    else
      "regular"
    end
  end

  # returns the color value
  def color_value(color)
    @color_map[color.to_sym]
  end
end
