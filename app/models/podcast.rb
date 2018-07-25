# frozen_string_literal: true

class Podcast < Entry
  before_save :embed_audio

  content_attr :long_title, :string
  content_attr :landscape_image, :string
  content_attr :card_image, :string
  content_attr :image_alt, :string
  content_attr :audio, :string
  content_attr :embedded_audio, :string
  content_attr :body, :text

  validates_presence_of :audio, :landscape_image, :card_image, :image_alt,
                        :long_title,
                        :body, :category, :description

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
      color_map = {
          red: "B03060",
          orange: "FF8243",
          yellow: "FFD700",
          olive: "32CD32",
          green: "21BA45",
          teal: "008080",
          blue: "2185D0",
          violet: "EE82EE",
          purple: "B413EC",
          pink: "FF1493",
          brown: "A52A2A",
          grey: "A0A0A0",
          black: "666666",
          white: "000000"
      }
      color_map[color.to_sym]
    end
end
