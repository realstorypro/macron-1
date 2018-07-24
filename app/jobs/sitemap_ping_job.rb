# frozen_string_literal: true

class SitemapPingJob < ActiveJob::Base
  def perform
    SitemapGenerator::Sitemap.default_host = "https://#{ENV['URL']}"
    SitemapGenerator::Sitemap.public_path = 'tmp/'
    SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                                                        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                                                        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                                                        fog_directory: ENV['AWS_S3_BUCKET'],
                                                                        fog_region: ENV['AWS_REGION'])

    SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['AWS_S3_BUCKET']}.s3.amazonaws.com/"
    SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

    SitemapGenerator::Sitemap.create do
      add root_path, changefreq: 'daily'

      add articles_path, priority: 0.7, changefreq: 'daily'
      Article.find_each do |article|
        add article_details_path(article.category.slug, article.slug), lastmod: article.updated_at
      end

      add discussions_path, priority: 0.7, changefreq: 'daily'
      Discussion.find_each do |discussion|
        add discussion_details_path(discussion.category.slug, discussion.slug), lastmod: discussion.updated_at
      end

      add videos_path, priority: 0.7, changefreq: 'daily'
      Video.find_each do |video|
        add video_details_path(video.category.slug, video.slug), lastmod: video.updated_at
      end
    end

    SitemapGenerator::Sitemap.ping_search_engines("https://#{ENV['URL']}/sitemap")
  end
end
