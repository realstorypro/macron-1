# frozen_string_literal: true

# Class acting as a proxy between Setting and SiteSettings
class SettingProxy
  include Singleton

  def initialize
    @settings = []
    @settings << Settings
  end

  # Returns the setting value based on the passed path.
  # @param path [String] the setting path separated by '.' notation.
  # @param options [Hash] options for the fetch operation.
  # @return [Object] the retreived settings value
  # @note if _options.fatal_exception_ is set to true then error will be thrown if the fragment is missing.
  def fetch(path, options = {})

    # split the path into an array
    path_array = path.split(".")

    # set the initial return value to nil
    value = nil

    @settings.each do |setting|
      path_array.each_with_index do |fragment, index|
        value = setting[fragment] if index.eql? 0
        value = value[fragment] unless index.eql? 0
      end
    end

    raise "fragment `#{fragment}` does not exist within `#{path}`" if value.nil? && options[:fatal_exception]
    value
  end
end
