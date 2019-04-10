# frozen_string_literal: true

class API::V1::FollowersController < ApplicationController
  # returns all followers for the current user
  def index
    @followers = current_user.followees(User)
  end

  def add
    followable = User.find(params[:id])
    current_user.follow! followable

    follow = Follow.where(follower: current_user, followable: followable).last
    follow.create_activity key: 'follower_created', owner: current_user, recipient: followable

    return head 200
  end

  def remove
    followable = User.find(params[:id])

    # get rid of the activity
    follow = Follow.where(follower: current_user, followable: followable).last
    activity = PublicActivity::Activity.where(trackable: follow, owner: current_user, recipient: followable).first
    activity.destroy

    # unfollow the followable
    current_user.unfollow! followable

    return head 200

  end
end
