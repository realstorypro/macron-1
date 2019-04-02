class API::V1::ActivitiesController < ApplicationController
  # TODO: Remove once we integrate
  skip_forgery_protection

  # returns activities for the current user
  def index
    params[:user_id] = current_user.id unless params[:user_id]
    feed = StreamRails.feed_manager.get_user_feed(params[:user_id])

    results = feed.get()['results']
    @activities = enricher.enrich_activities(results)
  end

  # returns single activity based on activity id
  def show

  end

  private

  def enricher
    enricher ||= StreamRails::Enrich.new
    enricher
  end
end