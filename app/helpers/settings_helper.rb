# frozen_string_literal: true

module SettingsHelper
  # TODO: factor this out with s() calls
  # this is needed because there are function calls still refer to it
  def settings(path, options = {})
    defaults = { fatal_exception: false }
    options = defaults.merge(options)

    SettingProxy.instance.fetch(path, options)
  end

  # Shortcut for settings with fatal exception enabled
  def s(path)
    SettingProxy.instance.s(path)
  end

  def ss(path)
    SettingProxy.instance.ss(path)
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
