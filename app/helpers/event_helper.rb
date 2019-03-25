# frozen_string_literal: true

module EventHelper
  def show_event_date(event)
    if event.start_date == event.end_date
      event.start_date
    else
      "#{event.start_date} &mdash; #{event.end_date}".html_safe
    end
  end
end
