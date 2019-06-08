# frozen_string_literal: true

class MetaController < ApplicationController
  include SettingsHelper
  include PathHelper

  before_action :entry_class
  before_action :component_name, only: %i[create update destroy]
  before_action :load_entry, only: %i[show edit update destroy]

  def index
    @entries = entry_class.all.order("name")
    authorize @entries
  end

  def show
    expires_in 2.minutes
  end

  def new
    @entry = entry_class.new
    @colors = Color.all
    authorize @entry
    render :new, layout: false
  end

  def edit
    @colors = Color.all
    render :edit, layout: false
  end

  def create
    @entry = entry_class.new(entry_params)
    if @entry.save
      flash[:success] = "#{component_name} was successfully created."
      response_status :success
      response_redirect helpers.meta_show_path(@entry, determine_namespace)
    else
      response_status :error
      render :new, layout: false
    end
  end

  def update
    if @entry.update(entry_params)
      flash[:success] = "#{component_name} was successfully updated."
      response_status :success
      redirect_back(fallback_location: admin_root_path)
    else
      response_status :error
      render :edit, layout: false
    end
  end

  def destroy
    @entry.destroy
    flash[:success] = "#{component_name} was successfully updated."
    response_status :success
    redirect_to helpers.meta_index_path determine_namespace
  end

    private

      # returns the entry class
      def entry_class
        @entry_class ||= settings("components.#{params[:component]}.klass", fatal_exception: true).classify.constantize
      end

      # retruns the component name
      def component_name
        @component_name ||= settings("components.#{params[:component]}.name")
      end

      def load_entry
        @entry = if slugged?(entry_class)
          entry_class.friendly.find(params[:id])
        else
          entry_class.find(params[:id])
        end
        authorize @entry
      end

      def entry_params
        allowed_attrs = set_allowed_attrs
        component = settings("components.#{params[:component]}.klass").downcase
        # we only want the class name without any other prefxes
        # TODO: Can this be removed?
        component = component.split("::").last.to_sym
        params.require(component).permit(*allowed_attrs)
      end

      # sets the allowed attributes
      def set_allowed_attrs
        allowed_attrs = %i[id]
        fields = settings("views.#{params[:component]}.new", fatal_exception: true)
        fields.each do |field|
          case field[1].type
          when "association" then allowed_attrs.append(Hash["#{node_name(field).to_s.singularize}_ids", []])
          when "association_dropdown" then allowed_attrs.append("#{node_name(field).to_s.singularize}_ids")
          when "dropdown" then allowed_attrs.append("#{node_name(field).to_s.singularize}_id")
          else allowed_attrs.append(node_name(field))
          end
        end
        allowed_attrs
      end

      # sets the response header status
      def response_status(kind)
        response.headers["status"] = kind.to_s
      end

      # sets the response header redirect
      def response_redirect(path)
        response.headers["redirect"] = path
      end

      # checks if the entry has a slug
      def slugged?(entry)
        entry.column_names.include? "slug"
      end

      # return the namespace
      def determine_namespace
        namespace = self.class.parent.to_s.downcase
        return nil if namespace.eql? "object"
        "admin"
      end

      # adds actions to the action list
      def add_to_actions(action)
        @actions ||= []
        @actions << action
      end
end
