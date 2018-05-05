# frozen_string_literal: true

# Extensions for the Symbols
class Symbol
  # returns true if the symbol is set to :on
  def on?
    return true if eql? :on
    false
  end

  # returns true if the symbol is set to :off
  def off?
    return true if eql? :off
    false
  end
end
