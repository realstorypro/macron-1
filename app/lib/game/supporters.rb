# frozen_string_literal: true

module Game::Supporters
  # returns all of the supporters the user has
  def supporters
    @player.user_followers
  end

  def supporters_count
    @player.followers_by_type_count('User')
  end

  # TODO BE REFACTORED
  def supporting?(user)
    return false unless user && @player
    @player.following?(user)
  end

  # support a user
  def support(user)
    @player.follow(user)
  end

  # stop supporting a user
  def stop_supporting(user)
    @player.stop_following(user)
  end
end
