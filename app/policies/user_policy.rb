# frozen_string_literal: true

class UserPolicy < MetaPolicy
  def ban?
    return true if action_authorized? :ban, @component
    false
  end

  def unban?
    return true if action_authorized? :unban, @component
    false
  end

  def verify?
    return true if action_authorized? :verify, @component
    false
  end

  def unverify?
    return true if action_authorized? :unverify, @component
    false
  end

  def enable_help?
    true
  end

  def disable_help?
    true
  end

  def enable_advanced?
    true
  end

  def disable_advanced?
    true
  end
end
