# frozen_string_literal: true

# rubocop:disable GlobalVars

module SiteSettings
  extend ActiveSupport::Concern

  included do
    before_action :load_site_settings
  end

  private

    def load_site_settings
      @site_settings = SiteSettingInterface.instance.fetch
    end
end

# rubocop:enable GlobalVars
