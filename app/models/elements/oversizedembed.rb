# frozen_string_literal: true

module Elements
  class Oversizedembed < Element
    include Autoloadable
    content_attr :embedded, :string
    content_attr :embedded_amp, :string

    before_save :embed
    before_save :embed_amp

    def embed
      unless url.blank?
        parsed_response = HTTParty
                              .get("https://iframe.ly/api/iframely?url=#{self.url}&api_key=#{ENV['IFRAMELY_API']}")
                              .parsed_response["html"]
        unless parsed_response
          parsed_response = false
        end

        self.embedded = parsed_response
      end
    end

    def embed_amp
      unless url.blank?
        parsed_response = HTTParty
                              .get("https://iframe.ly/api/iframely?url=#{self.url}&amp=1&api_key=#{ENV['IFRAMELY_API']}")
                              .parsed_response["html"]
        unless parsed_response
          parsed_response = false
        end

        self.embedded_amp = parsed_response
        end
      end
  end
end
