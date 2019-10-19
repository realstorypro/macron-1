# frozen_string_literal: true

# custom 'video' input type for simple_form
class VideoInput < SimpleForm::Inputs::Base
  include SettingsHelper
  def input(_wrapper_options)
    @builder.uploadcare_field(attribute_name, data: { tabs: "file camera url gphotos instagram" }).to_s.html_safe
  end
end
