# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  include SettingsHelper
  include Permissions

  def index?
    return true if action_authorized? :index, :profile
    false
  end

  def show?
    return true if action_authorized? :show, :profile
    false
  end

  def edit?
    return true if action_authorized? :edit, :profile, true
    false
  end

  def new?
    return true if action_authorized? :new, :profile
    false
  end

  def create?
    return true if action_authorized? :create, :profile
    false
  end

  def update?
    return true if action_authorized? :update, :profile, true
    false
  end

  def destroy?
    return true if action_authorized? :destroy, :profile, true
    false
  end
end
