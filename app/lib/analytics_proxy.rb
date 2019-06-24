# frozen_string_literal: true

# Handles event submission to Segment
class AnalyticsProxy
  include Singleton

  def initialize
    if ENV["SEGMENT_SERVER_KEY"]
      @segment = Segment::Analytics.new(
        write_key: ENV["SEGMENT_SERVER_KEY"],
        on_error: proc { |_status, msg| print msg }
      )
    end
  end

  # Identifies a logged in user with additional metadata.
  # @param [Object] user a user to identify (generally a current_user)
  def identify(user = nil)
    return false unless ENV["SEGMENT_SERVER_KEY"]
    return false unless user

    @segment.identify(
      user_id: user.id,
      traits: {
          username: user.username,
          email: user.email,
          avatar: user.profile.avatar,
          created_at: user.created_at
      })

    true
  end

  # Tracks an event, including the user, name and additional properties.
  # @param [Hash] params options to track
  # @option params [Object] :user User to track
  # @option params [String] :event Name of the event
  # @option params [Hash] :props Properties to track
  def track(params)
    return false unless ENV["SEGMENT_SERVER_KEY"]
    return false if params[:user].nil?
    return false if params[:event].nil?

    @segment.track(
      user_id: params[:user].id,
      event: params[:event],
      properties: params[:props]
    )
    true
  end
end
