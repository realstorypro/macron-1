# frozen_string_literal: true

module Elements
  class HeaderCell < BaseElementCell
    def show
      render "shared"
    end

    def header_size
      "fullscreen"
    end

    def title_extra_classes
      ""
    end

    def title_alignment
      model.title_alignment
    end

    def amped
      return true if options[:amped]
      false
    end
  end
end
