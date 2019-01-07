# frozen_string_literal: true
# s (args) -> settings('')
# ss -> settings('site.(args)')

# Class acting as a proxy between Setting and SiteSettings
class SettingProxy
  include Singleton

  def initialize
  end

  def fetch(path, params)
    if path.split(".")[0].include?("site")
      fetch_site_settings path, params
    else
      fetch_settings path, params
    end
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
