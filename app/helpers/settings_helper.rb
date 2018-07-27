# frozen_string_literal: true

# Responsible for helping with the settings object
module SettingsHelper
  # traverses the path and returns a setting
  def settings(path, options = {})
    # split the path into an array
    path_array = path.split(".")
    value = nil
    path_array.each_with_index do |fragment, index|
      value = Settings[fragment] if index.eql? 0
      value = value[fragment] unless index.eql? 0
      raise "fragment `#{fragment}` does not exist within `#{path}`" if value.nil? && options[:fatal_exception]
      return nil if value.nil?
    end
    value
  end

  # Shortcut for settings with fatal exception enabled
  def s(path)
    settings(path, fatal_exception: true)
  end

  # TODO: see if its possible to refactor out node_name and node_value

  # returns the name of the node
  def node_name(node)
    node[0].to_s
  end

  # returns the value of the node
  def node_value(node)
    node[1]
  end
end
