# frozen_string_literal: true

# Stores the user context to be used in Pundit
class UserContext
  attr_reader :user, :params
  def initialize(user, params)
    @user = user
    @params = params
  end
end
