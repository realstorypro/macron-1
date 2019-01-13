# frozen_string_literal: true

# Class acting as a proxy between Setting and SiteSettings
class SettingProxy
  include Singleton

  def initialize
  end

  # shortcut for accessing regular settings
  # @param [String] path string path in dot notation
  def s(path)
    fetch(path, fatal_exception: true)
  end

  # shortcut for site settings
  # @param [String] path string path in dot notation
  def ss(path)
    path_array = path.split(".")
    path_array.unshift("site") unless path_array[0].include?("site")
    fetch(path_array.join("."), fatal_exception: false)
  end

  # delegates setting requests between settings and site settings
  # @param [String] path a string path in dot notation
  # @param [Hash] params fetching options
  # @option params [Symbol] :fatal_exception raises fatal exception if set to true
  def fetch(path, params = {})
    path_array = path.split(".")

    if path_array[0].include?("site")
      fetch_site_settings path_array.drop(1).join("."), params
    else
      fetch_settings path_array.join("."), params
    end
  end

  # fetches settings value
  # @param [String] path a string path in dot notation
  # @param [Hash] options fetching options
  # @option params [Symbol] :fatal_exception raises fatal exception if set to true
  def fetch_settings(path, options = {})
    settings ||= SettingInterface.new(Settings)
    settings.fetch_setting(path, options)
  end

  # fetches site settings values
  # @param [String] path a string path in dot notation
  # @param [Hash] options fetching options
  # @option params [Symbol] :fatal_exception raises fatal exception if set to true
  def fetch_site_settings(path, options = {})
    site_settings = SiteSettingInterface.instance.fetch
    settings ||= SettingInterface.new(site_settings)
    settings.fetch_setting(path, options)
  end
end
