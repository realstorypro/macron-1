# frozen_string_literal: true

module Widget
  class BaseCell < Cell::ViewModel
    include ApplicationHelper
    include GoodUi::Helpers

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

    def site_setting(path, opts = {})
      settings ||= SettingInterface.new(options[:site_settings])
      settings.fetch_setting(path, fatal_exception: fatal)
    end

    # shortcut for site settings
    def ss(path)
      settings ||= SettingInterface.new(options[:site_settings])
      settings.fetch_setting(path, fatal_exception: true)
    end
  end
end
