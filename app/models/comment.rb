# frozen_string_literal: true

class Comment < ApplicationRecord
  include Activitible

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  belongs_to :user, counter_cache: true

  validates :body, presence: true

  before_save :sanitize_comment
  after_create :broadcast_activity


  def broadcast_activity
    # ActionCable.server.broadcast(
    #     "activity_#{self.actor.id}",
    #     activity_id: self.id
    # )
  end

  def self.policy_class
    CommentPolicy
  end

  private
    def sanitize_comment
      allows_tags = %w[p h2 h4 ul li strong a hr img]
      self.body = ActionController::Base.helpers.sanitize(body, tags: allows_tags)
    end
end
