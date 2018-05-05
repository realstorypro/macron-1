class UserPolicy < MetaPolicy
  def ban?
    return true if action_authorized? :ban, @component
    false
  end

  def unban?
    return true if action_authorized? :unban, @component
    false
  end
end
