# frozen_string_literal: true

class HeadlessPolicy
  include SettingsHelper
  include Permissions

  attr_reader :user
  def initialize(user, _record)
    @user = user
  end

  def index?(component)
    return true if action_authorized? :index, component
    false
  end

  def show?(component)
    return true if action_authorized? :show, component
    false
  end
end
