# frozen_string_literal: true

module Vue
  class WidgetCell < Cell::ViewModel
    include ApplicationHelper
    include GoodUi::Helpers
    delegate :url_helpers, to: "::Rails.application.routes"

    def show
      render :wrapper
    end

    def id
      uuid ||= Random.new.rand(100)
      name.gsub(" ", "_") + uuid.to_s
    end

    def current_user
      options[:current_user]
    end

    def name
      options[:name]
    end

    def data
      options[:data]
    end

    # shortcut for site settings
    def ss(path)
      settings ||= SettingInterface.new(options[:site_settings])
      settings.fetch_setting(path, fatal_exception: true)
    end
  end
end
