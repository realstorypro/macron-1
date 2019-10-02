# frozen_string_literal: true

module Elements
  class Image < Element
    include Autoloadable

    content_attr :width, :string
    content_attr :height, :string
    content_attr :format, :string

    before_save :set_dimensions
    before_save :set_format

    def set_dimensions
      return true unless self.image
      dimensions = FastImage.size(self.image)
      self.width = dimensions[0]
      self.height = dimensions[1]
    end

    def set_format
      return true unless self.image
      self.format = FastImage.type(self.image)
    end

  end
end
