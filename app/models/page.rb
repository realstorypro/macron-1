class Page < ApplicationRecord
  include Nameable
  include Slugged
  include Payloadable
  include Seoable

  after_update :ping_sitemap unless Rails.env.test?
  after_create :ping_sitemap unless Rails.env.test?

  def self.policy_class
    MetaPolicy
  end

  def ping_sitemap
    SitemapPingJob.perform_later
  end
end
