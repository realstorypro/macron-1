# frozen_string_literal: true

# rubocop:disable GlobalVars

module SiteSettings
  extend ActiveSupport::Concern

  included do
    before_action :load_site_settings
  end

  private

    def load_site_settings
      @site_settings = $site_setting_interface.fetch

      if @site_settings.nil?
        $site_setting_interface.update
        @analytics = Segment::Analytics.new(write_key: ss("integration.segment_server_key"))
      end

      @analytics ||= Segment::Analytics.new(write_key: ss("integration.segment_server_key"))
    end
end

# rubocop:enable GlobalVars
