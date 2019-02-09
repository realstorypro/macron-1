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

    ability = ability_from_action(action)

    user_roles.each do |role|
      return true if role_can?(role, ability, component, restrict_to_owner)
    end

    false
  end

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

  # fetches all of user roles
  # @return [Array] returns an array of role names
  def user_roles
    return @user.roles.pluck(:name) unless @user.nil?

    default_role = settings("defaults.permissions.visitor.role", fatal_exception: true)
    Array.wrap(default_role)
  end

  # looks up ability based on action
  # @param [String] action action the ability is linked to
  # @return [Symbol] ability linked to an action
  def ability_from_action(action)
    ability = settings("auth.actions.#{action}", fatal_exception: true)
    ability.to_sym
  end

  # checks if the role has an ability
  # @param [String] role role to check permission against
  # @param [String] ability to check permission against
  # @param [Boolean] restrict_to_owner ensures that the user performing the action is the owner of the record
  # @return [Boolean] returns true if the user is authorized and false if not
  def role_can?(role, ability, component, restrict_to_owner = false)
    # short circuit authorization is the role can do it all
    return true if settings("auth.permissions.#{role}.#{component}").methods.include?(:all)
    if settings("auth.permissions.#{role}.#{component}").methods.include?(ability)
      return true unless restrict_to_owner
      return true if @record.user.eql?(@user)
    end
    false
  end

  private
    # shortcut for site settings
    def ss(path)
      SettingProxy.instance.ss(path)
    end
end
