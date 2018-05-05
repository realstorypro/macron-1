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

    def load_site_settings
      site_settings = $redis.get('site_settings')

      if site_settings.nil?
        site_settings = Genesis::Setting.instance.to_json
        $redis.set('site_settings', site_settings)
      end

      @site_settings = JSON.parse(site_settings)
    end

    def ss(name)
      @site_settings['payload'][name.to_s]
    end
  end
end
# rubocop:enable GlobalVars
