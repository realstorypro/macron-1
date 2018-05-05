# frozen_string_literal: true

# custom 'input with a left icon' input type for simple_form
class LeftIconInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    template.content_tag :div, class: "ui left icon input" do
      template.concat @builder.text_field(attribute_name, merged_input_options)
      template.concat content_tag(:i, "", class: "#{merged_input_options[:icon]} icon")
    end
  end
end
