ActsAsVotable::Vote.class_eval do
  after_create :broadcast_activity

  def broadcast_activity
    ActionCable.server.broadcast("entry_#{self.votable.id}", entry_id: self.votable.id)
  end
end
