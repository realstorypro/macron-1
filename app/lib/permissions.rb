# frozen_string_literal: true

module Permissions
  def action_authorized?(action, component, restrict_to_owner = false)
    # short circuits authorization if the component is disabled
    return false unless component_enabled?(component)

    # fetches all of the users roles
    roles = fetch_user_roles
    ability = fetch_ability action

    authorized = false

    roles.each do |role|
      authorized = true if role_can?(role, ability, component, restrict_to_owner)
    end

    authorized
  end

  # checks if the component is enabled
  def component_enabled?(component)
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
end
