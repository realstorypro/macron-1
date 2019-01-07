# frozen_string_literal: true

# Class acting as a proxy between Segment and Ahoy
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

    user_id = nil if params[:user].nil?
    user_id = params[:user].id unless params[:user]

    @segment.track(
      user_id: user_id,
      event: params[:event],
      properties: params[:props]
    )

    true
  end

end
