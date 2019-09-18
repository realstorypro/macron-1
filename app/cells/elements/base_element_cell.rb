# frozen_string_literal: true

module Elements
  class BaseElementCell < Cell::ViewModel
    include ApplicationHelper
    include DcUi::Helpers

    delegate :url_helpers, to: "::Rails.application.routes"

    def show
      render
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
