# frozen_string_literal: true

class Comment < ApplicationRecord
  before_save :sanitize_comment
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  include PublicActivity::Model
  tracked owner: -> (controller, _model) { controller.current_user }

  belongs_to :user, counter_cache: true

  validates :body, presence: true

  def self.policy_class
    CommentPolicy
  end

  private
    def sanitize_comment
      allows_tags = %w[p h2 h4 ul li strong a hr img]
      self.body = ActionController::Base.helpers.sanitize(body, tags: allows_tags)
    end
end
