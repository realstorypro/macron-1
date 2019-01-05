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

  def identify(current_user = nil, traits = {})
    return true unless @segment
    return false if @segment && current_user.nil?
  end

  def track(current_user = nil, traits = {})
    return true unless @segment
  end

  private
    def segment_properties
    end
end
