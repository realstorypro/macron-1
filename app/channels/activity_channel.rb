# frozen_string_literal: true

class ActivityChannel < ApplicationCable::Channel
  def subscribed
    # TODO: Factor this out and make user always required
    params[:user_id] ||= current_user.id
    stream_from "activity_#{params[:user_id]}"
  end
end
