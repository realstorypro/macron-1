# frozen_string_literal: true

# Unifies event tracking for the application
module Trackable
  extend ActiveSupport::Concern
  # Unified event tracking
  # @param [Hash] params options to track
  # @option params [String] :event Name of the event
  # @option params [Hash] :props Properties to track
  def track(params)
    # record event in ahoy
    ahoy.track params[:event], params[:props]
  end
end
