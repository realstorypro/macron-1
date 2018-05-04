# frozen_string_literal: true

# frozen_string_literal: true

class Discussion < Entry
  content_attr :long_title, :string
  content_attr :long_summary, :text
  content_attr :landscape_image, :string
  content_attr :image_alt, :string
  content_attr :body, :text

  validates_presence_of :long_title, :long_summary,
                        :landscape_image, :image_alt,
                        :body, :category, :description
  paginates_per 25
end
