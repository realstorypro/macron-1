class API::V1::ActivitiesController < ApplicationController

  # returns all activities
  def index
    where_clause = {}
    where_clause['id'] = params[:activities] if params[:activities]
    @activities = PublicActivity::Activity.order("created_at desc")
                      .where(where_clause)
                      .preload(:owner, :trackable)
                      .offset(params[:offset])
                      .limit(10)
  end

  # returns activities for a single user
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