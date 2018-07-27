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

      if true || site_settings.nil?
        site_settings = Hash.new

        general_settings = SiteSettings::General.instance.payload
        branding_settings = SiteSettings::Branding.instance.payload
        contact_settings = SiteSettings::Contact.instance.payload
        #theme_settings = SiteSettings::Theme.instance.payload
        integration_settings = SiteSettings::Integration.instance.payload

        site_settings[:general] = general_settings
        site_settings[:branding] = branding_settings
        site_settings[:contact] = contact_settings
        #site_settings[:theme] = theme_settings
        site_settings[:integration] = integration_settings

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
