# frozen_string_literal: true

# rubocop:disable LineLength
# custom 'dropdown' input type for simple_form
class DropdownInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    collection = "#{attribute_name.capitalize}".constantize
    @builder.collection_select("#{attribute_name}_id", collection.all, :id, :name, { prompt: "Select #{attribute_name.capitalize}" }, { class: "ui dropdown" }).to_s.html_safe
  end
end
# rubocop:enable LineLength
