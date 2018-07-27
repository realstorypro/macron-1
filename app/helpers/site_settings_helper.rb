# frozen_string_literal: true

# Responsible for helping with the site settings object
module SiteSettingsHelper

  # returns the site setting from redis store
  def site_setting(path, options={})
    # split the path into an array
    path_array = path.split(".")
    value = nil
    path_array.each_with_index do |fragment, index|
      value = @site_settings[fragment] if index.eql? 0
      value = value[fragment] unless index.eql? 0
      raise "fragment `#{fragment}` does not exist within `#{path}`" if value.nil? && options[:fatal_exception]
      return nil if value.nil?
    end
    value
  end

  # shortcut for site settings
  def ss(name)
    site_setting name
  end
end
