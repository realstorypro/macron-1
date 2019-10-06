# frozen_string_literal: true

module Elements
  class HeaderCell < BaseElementCell
    def show
      render "shared"
    end

    def header_size
      "fullscreen"
    end
  end
end
