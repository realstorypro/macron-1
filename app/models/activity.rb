# frozen_string_literal: true

class Activity < ApplicationRecord
  include Payloadable

  after_create :broadcast_activity

  belongs_to :actor, polymorphic: true
  belongs_to :subject, polymorphic:  true

  content_attr :action

  def broadcast_activity
    ActionCable.server.broadcast(
      "activity_#{self.actor.id}",
        activity_id: self.id
    )
  end
end
