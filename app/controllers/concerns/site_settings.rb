# frozen_string_literal: true

# rubocop:disable GlobalVars

module SiteSettings
  extend ActiveSupport::Concern

  included do
    before_action :load_site_settings
  end

  private

    def load_site_settings
      site_settings = $redis.get("site_settings")

      if site_settings.nil?
        site_settings = Setting.instance.to_json
        $redis.set("site_settings", site_settings)
      end

      @site_settings = JSON.parse(site_settings)
    end
end

# rubocop:enable GlobalVars
