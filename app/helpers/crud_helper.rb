# frozen_string_literal: true

module CrudHelper
  def component_name(component = params[:component])
    settings "components.#{component}.name", fatal_exception: true
  end

  def component_new_fields(component = params[:component])
    settings "views.#{component}.new", fatal_exception: true
  end

  def component_list_fields(component = params[:component])
    settings "views.#{component}.list", fatal_exception: true
  end

  def component_show_fields(component = params[:component])
    settings "views.#{component}.show", fatal_exception: true
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

  def action_name(action = params[:action])
    action.capitalize
  end

  def field_name(field)
    field[0]
  end

  def field_type(field)
    field[1].type
  end

  def field_options(field)
    field[1].options
  end

  def field_label(field)
    field[1].label
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
