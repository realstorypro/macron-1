# frozen_string_literal: true

# Responsible for generating 'meta' paths from the component & entry
module PathHelper
  include SettingsHelper

  # Calls Path methods
  def meta_index_path(namespace = nil, component = params[:component])
    send(index_path(namespace, component))
  end

  def meta_new_path(namespace = nil, component = params[:component])
    send(new_path(namespace, component))
  end

  def meta_show_path(entry, namespace = nil, component = params[:component])
    send(show_path(namespace, component), entry)
  end

  def meta_edit_path(entry, namespace = nil, component = params[:component])
    send(edit_path(namespace, component), entry)
  end

  def meta_delete_path(entry, namespace = nil, component = params[:component])
    send(delete_path(namespace, component), entry)
  end

  # Generates the paths as strings
  def index_path(namespace = nil, component = params[:component])
    path = path_getter(component)
    if path.pluralize(nil) == path
      "#{in_namespace(namespace)}#{path}_path"
    else
      "#{in_namespace(namespace)}#{path}_index_path"
    end
  end

  def new_path(namespace = nil, component = params[:component])
    "new_#{in_namespace(namespace)}#{path_getter(component).singularize}_path"
  end

  def show_path(namespace = nil, component = params[:component])
    "#{in_namespace(namespace)}#{path_getter(component).singularize}_path"
  end

  def edit_path(namespace = nil, component = params[:component])
    "edit_#{in_namespace(namespace)}#{path_getter(component).singularize}_path"
  end

  def delete_path(namespace = nil, component = params[:component])
    "#{in_namespace(namespace)}#{path_getter(component).singularize}_path"
  end

  private

    def path_getter(component)
      settings "components.#{component}.path", fatal_exception: true
    end

    def in_namespace(namespace)
      return "#{namespace}_" unless namespace.nil?
      ""
    end
end
