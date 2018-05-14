# frozen_string_literal: true

# Responsible for handling real-time notifications
class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications"
  end
end
