# frozen_string_literal: true

# rubocop:disable GlobalVars

module SiteSettings
  extend ActiveSupport::Concern

  included do
    before_action :load_site_settings
  end

  private

    def load_site_settings
      # TODO: This can be further simplified
      @site_settings = SiteSettingInterface.instance.fetch
      SiteSettingInterface.instance.update if @site_settings.nil?
    end
end

# rubocop:enable GlobalVars
