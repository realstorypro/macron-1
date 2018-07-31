# frozen_string_literal: true

module SettingsHelper
  # this is needed because there are function calls still refer to it
  def settings(path, fatal = false)
    settings ||= SettingInterface.new(Settings)
    settings.fetch_setting(path, fatal_exception: fatal)
  end

  # Shortcut for settings with fatal exception enabled
  def s(path)
    settings ||= SettingInterface.new(Settings)
    settings.fetch_setting(path, fatal_exception: true)
  end

  # returns the name of the setting node
  def node_name(node)
    node[0].to_s
  end

  # returns the value of the setting node
  def node_value(node)
    node[1]
  end
end
