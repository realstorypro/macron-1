# frozen_string_literal: true

class Article < Entry
  include Autoloadable

  validates_presence_of :fullscreen_image, :landscape_image,
                        :card_image, :image_alt,
                        :long_title, :long_summary,
                        :body, :category, :description

  paginates_per 5
end
