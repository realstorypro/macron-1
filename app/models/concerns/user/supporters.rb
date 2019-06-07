# frozen_string_literal: true

module User::Supporters
  extend ActiveSupport::Concern

  included do
    def supporters
      self.user_followers
    end

    def supporters_count
      self.followers_by_type_count('User')
    end

    def supporting?(user)
      return false unless user
      self.following?(user)
    end

    # support a user
    def support(user)
      self.follow(user)
    end

    # stop supporting a user
    def stop_supporting(user)
      self.stop_following(user)
    end
  end
end
