# frozen_string_literal: true

class API::V1::ActivitiesController < ApplicationController
  # returns all activities
  def index
    where_clause = {}
    where_clause["id"] = params[:activities] if params[:activities]
    @activities = Activity.order("created_at desc")
                      .where(where_clause)
                      .offset(params[:offset])
                      .limit(10)
  end

  # returns activities for a single user
  def show
    where_clause = {}
    where_clause["actable_id"] = params[:id]
    where_clause["id"] = params[:activities] if params[:activities]

    @activities = Activity.order("created_at desc")
                      .where(where_clause)
                      .offset(params[:offset])
                      .limit(10)
  end
end
