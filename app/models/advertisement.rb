# frozen_string_literal: true

class Advertisement < Entry
  content_attr :url, :string
  content_attr :title, :string
  content_attr :text, :string
  content_attr :image, :string

  validates_presence_of :url, :title,
                        :text, :image

  validates :url, url: true
end
