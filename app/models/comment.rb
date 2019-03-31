# frozen_string_literal: true

class Comment < ApplicationRecord
  include StreamRails::Activity

  before_save :sanitize_comment
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  belongs_to :user, counter_cache: true

  validates :body, presence: true

  as_activity

  # Notifications
  def activity_object
    "#{self.commentable_type}:#{self.commentable_id}"
  end

  def activity_verb
    "commented on"
  end

  def activity_extra_data
    {
      slug: self.commentable.slug,
      category_slug: self.commentable.category.slug
    }
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
