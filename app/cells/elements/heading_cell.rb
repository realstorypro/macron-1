# frozen_string_literal: true

module Elements
  class HeadingCell < BaseElementCell
    def amped
      return true if options.respond_to?(:amped)
    end
  end
end
