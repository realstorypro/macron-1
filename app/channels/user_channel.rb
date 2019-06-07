# frozen_string_literal: true

class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{params[:user_id]}"
  end
end
