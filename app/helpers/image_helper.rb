# frozen_string_literal: true

module ImageHelper
  # Preloads Image for the Image Preload Widget
  def preload_image(src, klass = nil)
    image ui: :off, data: { 'src': src, klass: klass } do
      content_tag :div, class: "ui dimmer active" do
        content_tag :div, class: "ui small loader" do
        end
      end
    end
  end
end
