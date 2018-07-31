# frozen_string_literal: true

module Widget
  class BaseCell < Cell::ViewModel
    include ApplicationHelper
    include DcUi::Helpers

    delegate :url_helpers, to: "::Rails.application.routes"

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

    # TODO this is code duplication. find  way to remove this and only rely on site_settings_helper
    def site_setting(path, opts = {})
      # split the path into an array
      path_array = path.split(".")
      value = nil
      path_array.each_with_index do |fragment, index|
        value = options[:site_settings][fragment] if index.eql? 0
        value = value[fragment] unless index.eql? 0
        raise "fragment `#{fragment}` does not exist within `#{path}`" if value.nil? && opts[:fatal_exception]
        return nil if value.nil?
      end
      value
    end

    # shortcut for site settings
    def ss(path)
      site_setting(path, fatal_exception: true)
    end
  end
end
