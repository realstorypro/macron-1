# frozen_string_literal: true

# TODO: we're not using this ... maybe remove this later
class Activities < ApplicationCable::Channel
  def subscribed
    stream_from "activities"
  end
end
