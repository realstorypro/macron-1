# frozen_string_literal: true

# Handles the role based permission logic
module Permissions

  # Checks if the action is authorized
  # @param [String] action action to check
  # @param [String] component component on which the action is performed
  # @param [Boolean] restrict_to_owner determines whether
  #   action is only authorized for the resource owner
  # @return [Boolean] returns true if the action is authorized
  #   and false if it isn't.
  def action_authorized?(action, component, restrict_to_owner = false)
    # short circuits authorization if the component is disabled
    return false unless component_enabled?(component)

    # fetches all of the users roles
    roles = fetch_user_roles
    ability = fetch_ability action

    roles.each do |role|
      return true if role_can?(role, ability, component, restrict_to_owner)
    end

    false
  end

    # checks if the component is enabled
  def component_enabled?(component)
    # return false if the component has been disabled on the site basis
    site_components = ss("components")
    site_components.each do |site_component|
      return false if site_component["name"] == component.to_s && site_component["enabled"] == false
    end

    settings "components.#{component}.enabled", fatal_exception: true
  end

    # fetches all of the existing roles
  def fetch_user_roles
    return @user.roles.pluck(:name) unless @user.nil?

    default_role = settings("defaults.permissions.visitor.role", fatal_exception: true)
    Array.wrap(default_role)
  end

    # fetches the ability
  def fetch_ability(action)
    ability = settings("auth.actions.#{action}", fatal_exception: true)
    ability.to_sym
  end

    # checks if the role has an ability
  def role_can?(role, ability, component, restrict_to_owner = false)
    # short circuit authorization is the role can do it all
    return true if settings("auth.permissions.#{role}.#{component}").methods.include?(:all)
    if settings("auth.permissions.#{role}.#{component}").methods.include?(ability)
      return true unless restrict_to_owner
      return true if @record.user.eql?(@user)
    end
    false
  end

    # shortcut for site settings
  def ss(path)
    SettingProxy.instance.ss(path)
  end
end
