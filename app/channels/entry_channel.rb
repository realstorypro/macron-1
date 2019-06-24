# frozen_string_literal: true

class EntryChannel < ApplicationCable::Channel
  def subscribed
    stream_from "entry_#{params[:entry_id]}"
  end
end
