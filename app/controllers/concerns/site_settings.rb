# frozen_string_literal: true

# rubocop:disable GlobalVars
# rubocop:disable Metrics/LineLength

module SiteSettings
  extend ActiveSupport::Concern

  included do
    before_action :load_site_settings
  end

  private

    def load_site_settings
      site_settings = $redis.get("site_settings")

      if site_settings.nil?
        site_settings = Hash.new

        general_settings = SiteSettings::General.instance.payload
        contact_settings = SiteSettings::Contact.instance.payload
        integration_settings = SiteSettings::Integration.instance.payload
        article_theme_settings = SiteSettings::Theme::Article.instance.payload
        auth_theme_settings = SiteSettings::Theme::Authentication.instance.payload
        branding_theme_settings = SiteSettings::Theme::Branding.instance.payload
        discussion_theme_settings = SiteSettings::Theme::Discussion.instance.payload
        footer_theme_settings = SiteSettings::Theme::Footer.instance.payload
        global_theme_settings = SiteSettings::Theme::Global.instance.payload
        header_theme_settings = SiteSettings::Theme::Header.instance.payload
        homepage_theme_settings = SiteSettings::Theme::Homepage.instance.payload
        podcast_theme_settings = SiteSettings::Theme::Podcast.instance.payload
        video_theme_settings = SiteSettings::Theme::Video.instance.payload

        site_settings[:general] = general_settings
        site_settings[:contact] = contact_settings
        site_settings[:integration] = integration_settings

        site_settings[:theme] = {}
        site_settings[:theme][:article] = article_theme_settings
        site_settings[:theme][:auth] = auth_theme_settings
        site_settings[:theme][:branding] = branding_theme_settings
        site_settings[:theme][:discussion] = discussion_theme_settings
        site_settings[:theme][:footer] = footer_theme_settings
        site_settings[:theme][:global] = global_theme_settings
        site_settings[:theme][:header] = header_theme_settings
        site_settings[:theme][:homepage] = homepage_theme_settings
        site_settings[:theme][:podcast] = podcast_theme_settings
        site_settings[:theme][:video] = video_theme_settings

        site_settings = site_settings.to_json

        $redis.set("site_settings", site_settings)
      end
      
      @site_settings = JSON.parse(site_settings)

      # This isn't ideal as we're re-initing analytics with every call.
      # It would be nice to find a way to memoize it.
      @analytics = Segment::Analytics.new(write_key: ss("integration.segment_server_key"))
    end
end

# rubocop:enable GlobalVars
# rubocop:enable Metrics/LineLength
