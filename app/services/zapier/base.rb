# frozen_string_literal: true

# rubocop:disable GlobalVars
module Zapier
  class Base
    include HTTParty
    include SettingsHelper

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

      def load_site_settings
        @site_settings = SiteSettingInterface.instance.fetch
      end
  end
end
# rubocop:enable GlobalVars
