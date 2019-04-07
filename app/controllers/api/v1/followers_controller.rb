# frozen_string_literal: true

class API::V1::FollowersController < ApplicationController
  # returns all followers for the current user
  def index
    @followers = current_user.followees(User)
  end

  def add
    followee = User.find(params[:follower])
    current_user.follow! followee
    return head 200
  end

  def remove
    followee = User.find(params[:follower])
    current_user.unfollow! followee
    return head 200
  end
end
