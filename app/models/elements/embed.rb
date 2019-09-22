# frozen_string_literal: true

module Elements
  class Embed < Element
    include Autoloadable
    content_attr :embedded, :string

    before_save :embed

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

  end
end
