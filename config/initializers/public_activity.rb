PublicActivity::Activity.class_eval do
  after_create :broadcast_activity

  private

  def broadcast_activity
    ActionCable.server.broadcast(
        "activity_#{self.owner.id}",
        activity_id: self.id
    )

    ActionCable.server.broadcast(
        "activities",
        activity_id: self.id
    )
  end
end
