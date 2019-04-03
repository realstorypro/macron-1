class API::V1::ActivitiesController < ApplicationController

  # returns activities for the current user
  def index
    params[:user_id] ||= current_user.id
    @activities = PublicActivity::Activity.order("created_at desc")
                      .where(owner_id: params[:user_id])
                      .preload(:owner, :trackable)
  end

  # returns single activity based on activity id
  def show

  end

end