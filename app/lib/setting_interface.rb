# frozen_string_literal: true

# traverses the settings path
class SettingInterface
  def initialize(settings)
    @settings = settings
  end

  def fetch_setting(path, options = {})
    # split the path into an array
    path_array = path.split(".")
    value = nil
    path_array.each_with_index do |fragment, index|
      value = @settings[fragment] if index.eql? 0
      value = value[fragment] unless index.eql? 0
      raise "fragment `#{fragment}` does not exist within `#{path}`" if value.nil? && options[:fatal_exception]
      return nil if value.nil?
    end
    value
  end
end
