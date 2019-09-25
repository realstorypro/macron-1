# frozen_string_literal: true

module Entries
  class Podcast < Entry
    include Autoloadable
    include Activitible

    before_save :embed_audio
    content_attr :embedded_audio, :string

    validates_presence_of :category

    validates :audio, url: true
    validate :approved_audio_provider
    paginates_per 5

    def approved_audio_provider
      services = %w[soundcloud]
      return true if services.any? { |service| audio.include? service }
      errors.add(:audio, "Only Soudcloud URLs are allowed")
    end

    def embed_audio
      if audio.include?("soundcloud")
        resp = HTTParty.post(
          "https://soundcloud.com/oembed",
          body: {
              url: audio,
              maxheight: 170,
              color: play_button_color(category.color.name)
          }
        )
        self.embedded_audio = resp.parsed_response["oembed"]["html"]
      end
    end

    private
      def play_button_color(color)
        palette = Palette.new
        palette.color_value(color)
      end
  end
end
