# frozen_string_literal: true

module Admin
  class ElementsCell < Cell::ViewModel
    include ApplicationHelper
    include DcUi::Helpers

    delegate :url_helpers, to: "::Rails.application.routes"

    def element_icon (element)
      icon(s("components.#{element.type.downcase.gsub('::','_')}.icon"))
    end

    # shortcuts
    def area_name
      options[:area]
    end

    def areas
      options[:areas]
    end

    def controller_namespace
      options[:controller_namespace]
    end

    def current_user
      options[:user]
    end
  end
end
