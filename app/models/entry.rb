# frozen_string_literal: true

class Entry < ApplicationRecord
  include StreamRails::Activity
  include Nameable
  include Payloadable
  include Categorizable
  include Taggable
  include Slugged
  include Seoable

  as_activity

  validates :slug, uniqueness: { scope: :type, allow_blank: true }
  scope :published, (-> { all.where.not(published_date: nil) })

  after_update :ping_sitemap unless Rails.env.test?
  after_create :ping_sitemap unless Rails.env.test?

  belongs_to :user, optional: true
  has_many :comments, as: :commentable
  has_many :areas, as: :areable
  has_many :elements, through: :areas

  # Notifications
  def activity_extra_data
    {'slug' => self.slug}
  end

  def activity_object
    self.model_name.human
  end

  def activity_verb
    "published"
  end

  # Security
  def self.policy_class
    MetaPolicy
  end

  def ping_sitemap
    SitemapPingJob.perform_later
  end
end
