# frozen_string_literal: true

class MetaPolicy < ApplicationPolicy
  include SettingsHelper
  include Permissions

  def index?
    return true if action_authorized? :index, @component
    false
  end

  def show?
    return true if action_authorized? :show, @component
    false
  end

  def edit?
    return true if action_authorized? :edit, @component
    false
  end

  def new?
    return true if action_authorized? :new, @component
    false
  end

  def create?
    return true if action_authorized? :create, @component
    false
  end

  def update?
    return true if action_authorized? :update, @component
    false
  end

  def destroy?
    return true if action_authorized? :destroy, @component
    false
  end
end
