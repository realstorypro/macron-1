# frozen_string_literal: true

class Follow < ActiveRecord::Base

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true
  belongs_to :follower,   :polymorphic => true

  after_create :broadcast_activity
  after_destroy :broadcast_activity

  def block!
    self.update_attribute(:blocked, true)
  end

  def broadcast_activity
    ActionCable.server.broadcast(
        "player_#{self.followable.id}",
        user_id: self.followable.id
    )
  end
end
