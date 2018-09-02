# frozen_string_literal: true

module Admin
  class ElementsCell < Cell::ViewModel
    include ApplicationHelper
    include DcUi::Helpers

    # shortcuts
    def area_name
      options[:area]
    end

    def areas
      options[:areas]
    end

    def reorder_path
      options[:reorder_path]
    end
  end
end
