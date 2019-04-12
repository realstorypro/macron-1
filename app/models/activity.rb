# frozen_string_literal: true

class Activity < ApplicationRecord
  include Payloadable

  after_create :broadcast_activity

  belongs_to :actable, polymorphic: true
  belongs_to :subjectable, polymorphic:  true

  content_attr :action

  def broadcast_activity
    ActionCable.server.broadcast(
        "activity_#{self.actable.id}",
        activity_id: self.id
    )

    ActionCable.server.broadcast(
        "activities",
        activity_id: self.id
    )
  end

end
