# frozen_string_literal: true

module CrudHelper
  def component_name(component = params[:component])
    settings "components.#{component}.name", fatal_exception: true
  end

  def component_new_fields(component = params[:component])
    settings "views.#{component}.new", fatal_exception: true
  end

  def component_list_fields(component = params[:component])
    list_fields = settings("views.#{component}.list")
    list_fields = settings ("views.defaults.list") unless list_fields
    list_fields
  end

  def component_basic_list_fields(component = params[:component])
    basic_list = settings ("views.#{component}.basiclist")
    basic_list = settings ("views.defaults.basiclist") unless basic_list
    basic_list
  end

  def component_show_fields(component = params[:component])
    show_list = settings("views.#{component}.show")
    show_list = settings("views.#{component}.new") unless show_list
    show_list
  end

  def component_description(component = params[:component])
    settings "components.#{component}.description", fatal_exception: false
  end


  def component_help_link(component = params[:component])
    link = settings "components.#{component}.help_link", fatal_exception: false
    if link
      link_to "Learn More &raquo;".html_safe, link, target: "_blank"
    else
      nil
    end
  end

  def component_areas(component = params[:component])
    settings "components.#{component}.areas", fatal_exception: false
  end

  def element_component_name(element)
    element.type.gsub("::", "_").downcase
  end

  def action_name(action = params[:action])
    action.capitalize
  end

  def field_name(field)
    field[0]
  end

  def field_type(field)
    field[1].type
  end

  def field_advanced(field)
    field[1].advanced
  end

  def field_options(field)
    field[1].options
  end

  def field_label(field)
    if field[1].respond_to?(:icon)
      "#{icon(field[1].icon)} #{field[1].label}".html_safe
    else
      field[1].label
    end
  end

  def field_hint(field)
    field[1].hint
  end

  def field_text(field)
    field[1].text
  end

  def field_maxlength(field)
    field[1].maxlength
  end
end
