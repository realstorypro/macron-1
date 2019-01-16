# frozen_string_literal: true

module ImageHelper
  # Preloads Image for the Image Preload Widget
  def preload_image(src, klass = nil, alt_text = nil)
    rtr_str = image_tag "", alt: alt_text
    rtr_str << content_tag(:div, class: "ui dimmer active") do
      content_tag :div, class: "ui small loader" do
      end
    end

    image ui: :off , data: { 'src': src, klass: klass }do
      rtr_str
    end
  end
end
