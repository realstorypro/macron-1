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
    return true unless @segment
    return false if @segment && user.nil?

    if @segment && user
      Analytics.identify(
        user_id: user.id,
        traits: {
            username: user.username,
            email: user.email,
            avatar: user.profile.avatar,
            created_at: user.created_at
        })

      return true
    end
  end

  def track(user = nil, traits = {})
    return true unless @segment
  end

  private
    def segment_properties
    end
end
