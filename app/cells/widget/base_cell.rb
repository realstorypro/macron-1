# frozen_string_literal: true

module Widget
  class BaseCell < Cell::ViewModel
    include ApplicationHelper
    include DcUi::Helpers

    delegate :url_helpers, to: "Rails.main_app.routes"

    def show
      render(options[:layout])
    end

    def component
      options[:component]
    end

    def component_name
      s("components.#{options[:component]}.name")
    end

    def component_path
      s("components.#{options[:component]}.path")
    end
  end
end
