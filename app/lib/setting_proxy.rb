# frozen_string_literal: true

# Class acting as a proxy between Setting and SiteSettings
class SettingProxy
  include Singleton

  def initialize
  end

  def fetch_settings(path, options = {})
    settings ||= SettingInterface.new(Settings)
    settings.fetch_setting(path, fatal_exception: true)
  end

  def fetch_site_settings(path, options = {})
    site_settings = SiteSettingInterface.instance.fetch
    settings ||= SettingInterface.new(site_settings)
    settings.fetch_setting(path, fatal_exception: true)
  end
end
