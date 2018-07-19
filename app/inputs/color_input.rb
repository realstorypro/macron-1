# frozen_string_literal: true

class ColorInput < SimpleForm::Inputs::CollectionSelectInput
  def input(_wrapper_options)
    menu_items = ActiveSupport::SafeBuffer.new

    collection.each do |color|
      collection_item = ActiveSupport::SafeBuffer.new
      collection_item << content_tag(:span, "", class: "color icon #{color}")
      collection_item << " #{color}"

      menu_items << content_tag(:div, collection_item,
                                class: "ui item #{'active' if color == object.send(attribute_name)}",
                                data: { value: color })
    end

    header = content_tag(:div, "Select Color", class: "ui header")

    menu = content_tag(:div, header + menu_items, class: "menu").html_safe

    icon = content_tag(:i, "", class: "dropdown")
    hidden_input = @builder.hidden_field(attribute_name).html_safe
    blank_text = content_tag(:div, "Select Color", class: "default text")

    dropdown = content_tag(:div, icon + hidden_input + blank_text + menu, class: "ui selection dropdown colored")

    out = ActiveSupport::SafeBuffer.new
    out << dropdown
    out
  end
end
