# frozen_string_literal: true

class Video < Entry
  before_save :embed_video

  content_attr :long_title, :string
  content_attr :landscape_image, :string
  content_attr :card_image, :string
  content_attr :image_alt, :string
  content_attr :video, :string
  content_attr :embedded_video, :string
  content_attr :body, :text

  validates_presence_of :video, :landscape_image, :card_image, :image_alt,
                        :long_title,
                        :body, :category, :description

  validates :video, url: true
  validate :approved_video_provider
  paginates_per 5

  def approved_video_provider
    services = %w[vimeo youtube]
    return true if services.any? { |service| video.include? service }
    errors.add(:video, "Only Vimeo and Youtube URLs are allowed")
  end

  def embed_video
    # vimeo post processing
    if video.include?('vimeo')
      self.embedded_video = video.gsub("vimeo.com/", "player.vimeo.com/video/")
    end

    # youtube post processing
    if video.include?('youtube')
      # makes regular video embeddable
      self.embedded_video = video.gsub("www.youtube.com/watch?v=", "www.youtube.com/embed/")

      # removes the ampersand from a string
      ampersand_location = self.embedded_video.index('&')
      if ampersand_location
        self.embedded_video = self.embedded_video[0..(ampersand_location-1)]
      end
    end
  end
end
