# frozen_string_literal: true

class Entry < ApplicationRecord
  include Nameable
  include Payloadable
  include Categorizable
  include Taggable
  include Slugged
  include Seoable
  include Pointable

  acts_as_followable
  acts_as_votable

  validates :slug, uniqueness: { scope: :type, allow_blank: true }
  scope :published, (-> { all.where.not(published_date: nil) })

  after_update :ping_sitemap unless Rails.env.test? || Rails.env.development?
  after_create :ping_sitemap unless Rails.env.test? || Rails.env.development?

  belongs_to :user, optional: true
  has_many :comments, as: :commentable
  has_many :areas, as: :areable
  has_many :elements, through: :areas

  # Security
  def self.policy_class
    MetaPolicy
  end

  def ping_sitemap
    SitemapPingJob.perform_later
  end
end
