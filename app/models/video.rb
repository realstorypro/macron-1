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
    services = %w[vimeo]
    return true if services.any? { |service| video.include? service }
    errors.add(:video, "Only Vimeo URLs are allowed")
  end

  def embed_video
    self.embedded_video = video.gsub("vimeo.com/", "player.vimeo.com/video/")
  end
end
