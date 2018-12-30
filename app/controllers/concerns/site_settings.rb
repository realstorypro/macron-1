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
      @site_settings = $site_setting_interface.fetch_json
      $site_setting_interface.update unless @site_settings.nil?

      # This isn't ideal as we're re-initing analytics with every call.
      # It would be nice to find a way to memoize it.
      @analytics = Segment::Analytics.new(write_key: ss("integration.segment_server_key"))
    end
end

# rubocop:enable GlobalVars
# rubocop:enable Metrics/LineLength
