# frozen_string_literal: true

# Loading Site Settings
@site_settings = JSON.parse($redis.get("site_settings"))

unless @site_settings["payload"]["segment_server_key"].nil?
  Analytics = Segment::Analytics.new(
      write_key: @site_settings["payload"]["segment_server_key"],
      on_error: proc { |_status, msg| print msg }
  )
end
