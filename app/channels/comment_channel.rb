# frozen_string_literal: true

class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:component]}_#{params[:record]}"
  end
end
