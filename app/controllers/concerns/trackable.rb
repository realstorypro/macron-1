# frozen_string_literal: true

# simplifies event tracking by delegating events to both ahoy and segment
module Trackable
  extend ActiveSupport::Concern
  require 'ostruct'

  # identifies a user
  # @param [Object] user user to identify, defaults to current_user
  def identify(user = current_user)
    AnalyticsProxy.instance.identify(user)
  end

  # tracks behavior
  # @param [Object] params parameters to track
  def track(params)

    # set the default parameters for user
    params[:user] = OpenStruct.new(id: current_visit.visitor_token) unless current_user
    params[:user] = current_user if current_user

    # record event in ahoy
    ahoy.track params[:event], params[:props]

    # record even in segment via proxy
    AnalyticsProxy.instance.track(params)
  end
end
