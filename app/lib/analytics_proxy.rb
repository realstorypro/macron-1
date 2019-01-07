# frozen_string_literal: true

# Handles event submission to Segment
class AnalyticsProxy
  include Singleton

  attr_accessor :segment

  def initialize
    if ENV["SEGMENT_SERVER_KEY"]
      @segment = Segment::Analytics.new(
        write_key: ENV["SEGMENT_SERVER_KEY"],
        on_error: proc { |_status, msg| print msg }
      )
    end
  end

  def identify(user = nil)
    return false unless @segment
    return false if @segment && user.nil?

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

  def track(params)
    return false unless @segment
    return false if @segment && params[:user].nil?
    return false if params[:event].nil?

    @segment.track(
      user_id: params[:user].id,
      event: params[:event],
      properties: params[:props]
    )

    true
  end
end
