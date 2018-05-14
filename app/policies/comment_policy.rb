# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  include SettingsHelper
  include Permissions

  def index?
    return true if action_authorized? :index, :comments
    false
  end

  def show?
    return true if action_authorized? :show, :comments
    false
  end

  def edit?
    return true if action_authorized? :edit, :comments, true
    false
  end

  def new?
    return true if action_authorized? :new, :comments
    false
  end

  def create?
    return true if action_authorized? :create, :comments
    false
  end

  def update?
    return true if action_authorized? :update, :comments, true
    false
  end

  def destroy?
    return true if action_authorized? :destroy, :comments, true
    false
  end
end
