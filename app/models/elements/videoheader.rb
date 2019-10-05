# frozen_string_literal: true

module Elements
  class Videoheader < Element
    include Autoloadable

    validates :video, url: true
  end
end
