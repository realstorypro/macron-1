# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  include SettingsHelper
  include Permissions

  def index?
    return true if action_authorized? :index, :profiles
    false
  end

  def show?
    return true if action_authorized? :show, :profiles
    false
  end

  def edit?
    return true if action_authorized? :edit, :profiles, true
    false
  end

  def new?
    return true if action_authorized? :new, :profiles
    false
  end

  def create?
    return true if action_authorized? :create, :profiles
    false
  end

  def update?
    return true if action_authorized? :update, :profiles, true
    false
  end

  def destroy?
    return true if action_authorized? :destroy, :profiles, true
    false
  end
end
