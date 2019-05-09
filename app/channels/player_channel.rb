# frozen_string_literal: true

class PlayerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "players"
  end
end
