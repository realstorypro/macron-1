class ColorInerface
  attr_accessor :colors, :regular, :inverted

  def initialize(options)
    defaults = {
        colors: %w(black blue green),
        regular: %w(green),
        inverted: %w(red blue olive green teal purple pink brown black)
    }
    options = defaults.merge(options)

    @colors = options[:colors]
    @regular = options[:regular]
    @inverted = options[:inverted]
  end
end