# frozen_string_literal: true

module Widget
  class BaseCell < Cell::ViewModel
    include ApplicationHelper

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
