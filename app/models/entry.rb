# frozen_string_literal: true

class Entry < ApplicationRecord
  include Nameable
  include Payloadable
  include Categorizable
  include Taggable
  include Slugged
  include Seoable

  validates :slug, uniqueness: { scope: :type, allow_blank: true }
  scope :published, (-> { all.where.not(published_date: nil) })

  has_many :comments, as: :commentable

  def self.policy_class
    MetaPolicy
  end
end
