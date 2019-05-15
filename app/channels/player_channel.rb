# frozen_string_literal: true

class PlayerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{params[:user_id]}"
  end
end
