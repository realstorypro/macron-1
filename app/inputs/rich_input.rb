# frozen_string_literal: true

# custom 'rich' input type for simple_form
class RichInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.text_area(attribute_name, merged_input_options).to_s.html_safe
  end
end
