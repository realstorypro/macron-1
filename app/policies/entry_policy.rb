# frozen_string_literal: true

class EntryPolicy < ApplicationPolicy
  include SettingsHelper
  include Permissions

  def index?
    return true if action_authorized? :index, @component
    false
  end

  def show?
    # for entries we only want to display record if it has been published
    # or if the editor has an edit ability.
    if record.published_date && record.published_date <= Date.today
      return true
    else
      return true if action_authorized? :edit, @component
    end

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
