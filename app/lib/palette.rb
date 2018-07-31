class Palette
  attr_accessor :colors, :regular, :inverted

  def initialize(options = {})
    defaults = {
        colors: %w(red orange yellow olive green teal blue violet purple pink brown grey black white ),
        inverted: %w(red blue olive green teal purple pink brown black)
    }
    options = defaults.merge(options)

    @colors = options[:colors]
    @inverted = options[:inverted]
  end

  # retruns whether the color is regular or inverted
  def contrast(color)
    if @inverted.include?(color)
      "inverted"
    else
      "regular"
    end
  end

end

