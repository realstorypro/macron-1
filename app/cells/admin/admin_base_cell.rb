# frozen_string_literal: true

module Admin
  class AdminBaseCell < Cell::ViewModel
    include ApplicationHelper
    include ActionView::Helpers::DateHelper
    include DcUi::Helpers
    delegate :url_helpers, to: "::Rails.application.routes"

    ########################################################
    #  Record Render Main Switch
    ########################################################

    # renders record value based on field type
    def record_value(field, row = nil)
      data_type = DisplayDataType.new()

      # look up the field type
      type = field_type(field)

      # header does not have value so we want to ignore it
      value = field_value(field, row) unless type == "header"

      # guard close to exit if there is no value
      return if value.nil?

      case data_type.which?(type)
      when :string, :text, :integer
        value
      when :date
        "#{time_ago_in_words(value)} ago"
      when :image
        render_image(value, "small")
      when :dropdown
        render_linked_item (value)
      when :association
        render_list(value, true)
      when :linked_list
        render_list(value, true)
      when :unlinked_list
        render_list(value, false)
      when :color
        if value.respond_to?(:name)
          render_color(value.name)
        else
          render_color(value)
        end
      end
    end

    ########################################################
    #  Rendering Methods
    ########################################################

    def render_list(items, linked = false)
      items = items.reorder("name")
      link_path = "admin_#{items.model.name.downcase}_path"

      rendering = ActiveSupport::SafeBuffer.new

      items.each_with_index do |item, _index|
        if linked
          rendering << (link_to(item.name, url_helpers.send(link_path, item), class: "ui label blue"))
        else
          rendering << (content_tag(:div, item.name, class: "ui label mini").html_safe)
        end
      end

      content_tag(:div, rendering.html_safe, class: "ui labels")
    end

    # returns linked item
    def render_linked_item(item)
      rendering = ActiveSupport::SafeBuffer.new

      unless item.nil?
        link_path = "admin_#{item.model_name.name.downcase}_path"
        rendering << (link_to(item.name, url_helpers.send(link_path, item)))
      end

      rendering.html_safe
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

    def field_value(field, row)
      # sets value base from either passed record or current row
      base = if row.nil?
        options[:records]
      else
        row
      end

      # pulls in value from either association or record itself
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
