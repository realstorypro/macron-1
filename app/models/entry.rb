# frozen_string_literal: true

class Entry < ApplicationRecord
  include Nameable
  include Payloadable
  include Categorizable
  include Taggable
  include Slugged
  include Seoable

  # Necessery to fix a really weird error with the STI
  # https://github.com/galetahub/ckeditor/issues/739 <- somewhat related info
  # self.inheritance_column = nil

  acts_as_followable
  acts_as_likeable

  validates :slug, uniqueness: { scope: :type, allow_blank: true }
  scope :published, (-> { all.where.not(published_date: nil) })

  after_update :ping_sitemap unless Rails.env.test? || Rails.env.development?
  after_create :ping_sitemap unless Rails.env.test? || Rails.env.development?
  after_update :delete_old_author_activity

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

  # TODO: Implement delete the old author activity if the author has changed
  def delete_old_author_activity
  end
end

require_dependency 'article'
