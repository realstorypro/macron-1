class API::V1::ActivitiesController < ApplicationController

  # returns activities for the current user
  def index
    @activities = PublicActivity::Activity.order("created_at desc")
                      .preload(:owner, :trackable)
  end

  # returns single activity based on activity id
  def show
    where_clause = {}
    where_clause['owner_id'] = params[:id]
    where_clause['id'] = params[:activities] if params[:activities]

    @activities = PublicActivity::Activity.order("created_at desc")
                      .where(where_clause)
                      .offset(params[:offset])
                      .preload(:owner, :trackable)
                      .limit(10)
  end
end