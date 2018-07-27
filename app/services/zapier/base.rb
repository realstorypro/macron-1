# frozen_string_literal: true

# rubocop:disable GlobalVars
module Zapier
  class Base
    include HTTParty

    attr_accessor :error_message, :response, :code, :body
    attr_reader :resource

    def initialize(resource)
      @resource = resource
      load_site_settings
    end

    def post_to_zapier
      self.response = call_operation
      self.body = response.parsed_response
      self.code = response.code
      self.error_message = response.body
      success?
    end

    def success_status_codes
      [200]
    end

    def success?
      return true if success_status_codes.include?(code)
      Rails.logger.error(error_message)
      false
    end

    private

      # TODO: we don't want to load this guy twice

      def load_site_settings
        site_settings = $redis.get("site_settings")

        if site_settings.nil?
          site_settings = Hash.new

          general_settings = SiteSettings::General.instance.payload
          branding_settings = SiteSettings::Branding.instance.payload
          contact_settings = SiteSettings::Contact.instance.payload
          theme_settings = SiteSettings::Theme.instance.payload
          integration_settings = SiteSettings::Integration.instance.payload

          site_settings.merge!(general_settings)
          site_settings.merge!(branding_settings)
          site_settings.merge!(contact_settings)
          site_settings.merge!(theme_settings)
          site_settings.merge!(integration_settings)


          site_settings = { payload: site_settings }.to_json

          $redis.set("site_settings", site_settings)
        end

        @site_settings = JSON.parse(site_settings)
      end

      def ss(name)
        @site_settings["payload"][name.to_s]
      end
  end
end
# rubocop:enable GlobalVars
