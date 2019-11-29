# frozen_string_literal: true

module Elements
  class HeadingCell < BaseElementCell
    def amped
      return true if options.respond_to?(:amped)
    end

    def alignment
      return "#{model.alignment} aligned" unless model.alignment.nil?
      ''
    end
  end
end
