Analytics = Segment::Analytics.new(
    write_key: ENV['SEGMENT_SERVER_KEY'],
    on_error: proc { |_status, msg| print msg }
)