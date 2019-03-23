# frozen_string_literal: true

module ComponentHelper
  # Checks if the component is enabled
  # @param [String] component component to check
  # @return [Boolean] returns true if the component is enabled
  #   and false if it isn't.
  def component_enabled?(component)
    # return false if the component has been disabled on the site basis
    site_components = ss("components")
    site_components.each do |site_component|
      return false if site_component["name"] == component.to_s && site_component["enabled"] == false
    end

    settings "components.#{component}.enabled", fatal_exception: true
  end
end
