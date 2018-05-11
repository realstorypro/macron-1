# frozen_string_literal: true

# rubocop:disable CyclomaticComplexity
module Admin
  class BaseCell < Cell::ViewModel
    include ApplicationHelper
    include ActionView::Helpers::DateHelper
    include DcUi::Helpers

    ########################################################
    #  Record Render Main Switch
    ########################################################

    # renders record value based on field type
    def record_value(field, row = nil)
      type = field_type(field)
      value = get_value(field, row) unless type == "header"

      return if value.nil?
      case type
      when "string"
        value
      when "date"
        "#{time_ago_in_words(value)} ago"
      when "image_medium"
        render_image(value, "medium")
      when "image_small"
        render_image(value, "small")
      when "image_mini"
        render_image(value, "mini")
      when "image_tiny"
        render_image(value, "tiny")
      when "linked_list"
        render_list(value, true)
      when "unlinked_list"
        render_list(value, false)
      when "linked_item"
        render_linked_item(value)
      when "color"
        render_color(value.name)
      end
    end

    ########################################################
    #  Rendering Methods
    ########################################################

    def render_list(items, linked = false)
      items = items.reorder("name")
      link_path = "admin_#{items.model.name.downcase}_path"

      content = ""

      items.each_with_index do |item, _index|
        if linked
          content.concat(link_to(item.name, send(link_path, item), class: "ui label blue"))
        else
          content.concat(content_tag(:div, item.name, class: "ui label mini").html_safe)
        end
      end

      content_tag(:div, content.html_safe, class: "ui labels")
    end

    # returns linked item
    def render_linked_item(item)
      content = ""

      unless item.nil?
        link_path = "admin_#{item.model_name.name.downcase}_path"
        content.concat(link_to(item.name, send(link_path, item)))
      end

      content.html_safe
    end

    # returns an image
    def render_image(src, size)
      case size
      when "medium"
        image_tag(src, class: "ui rounded medium image")
      when "small"
        image_tag(src, class: "ui rounded small image")
      when "mini"
        image_tag(src, class: "ui rounded mini image")
      when "tiny"
        image_tag(src, class: "ui rounded tiny image")
      end
    end

    # renders a colored tag
    def render_color(item)
      tagging text: item, class: item
    end

    ########################################################
    #  Value Calculation Methods
    ########################################################

    def get_value(field, row)
      # sets value base from either passed record or current row
      base = if row.nil?
        options[:records]
      else
        row
      end

      # pulls in value from either association ore record itself
      value = if association(field)
        base.send(association(field)).send(name(field))
      else
        base.send(name(field))
      end

      # applies the scope to the query if one is defined
      value = value.send scope(field) if scope(field)
      value
    end

    ########################################################
    #  Helper Methods
    ########################################################

    # shortcut for association property in the config file
    def association(field)
      field[1].association
    end

    # shortcut for scope property in the config file
    def scope(field)
      field[1].scope
    end

    # shortcut for name in the config file
    def name(field)
      field_name(field)
    end
  end
end
# rubocop:enable CyclomaticComplexity
