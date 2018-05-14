# frozen_string_literal: true

# custom 'rich' input type for simple_form
class ImageInput < SimpleForm::Inputs::Base
  include SettingsHelper
  def input(_wrapper_options)
    image_size = size(attribute_name)
    @builder.uploadcare_field(attribute_name, data: { 'images-only': true, crop: image_size }).to_s.html_safe
  end

  private

    def size(attribute_name)
      component = options[:component]
      size = settings("views.#{component}.new.#{attribute_name}.size")

      return "free" unless size

      size[0] + "x" + size[1]
    end
end
