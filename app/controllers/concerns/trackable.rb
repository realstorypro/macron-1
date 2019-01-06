# frozen_string_literal: true

module Trackable
  extend ActiveSupport::Concern

  def identify(user = current_user)
    AnalyticsProxy.instance.identify(user)
  end

  # tracks behavior
  def track(params)
    ahoy.track params[:event], params[:props]
    AnalyticsProxy.instance.track(params)
  end
end
