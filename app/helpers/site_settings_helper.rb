# frozen_string_literal: true

# Responsible for helping with the site settings object
module SiteSettingsHelper
  # shortcut for site settings
  def ss(path)
    settings ||= SettingInterface.new(@site_settings)
    settings.fetch_setting(path, fatal_exception: true)
  end
end
