# frozen_string_literal: true

class Article < Entry
  content_attr :long_title, :string
  content_attr :long_summary, :text
  content_attr :fullscreen_image, :string
  content_attr :landscape_image, :string
  content_attr :card_image, :string
  content_attr :image_alt, :string
  content_attr :body, :text

  validates_presence_of :fullscreen_image, :landscape_image,
                        :card_image, :image_alt,
                        :long_title, :long_summary,
                        :body, :category, :description

  paginates_per 5
end
