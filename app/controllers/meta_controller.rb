# frozen_string_literal: true

class MetaController < ApplicationController
  include SettingsHelper
  include PathHelper

  before_action :load_entry, only: %i[show edit update destroy]

  def index
    if component.klass.column_names.include?("published_date")
      @entries = component.klass.all.order("published_date desc")
    else
      @entries = component.klass.all.order("name")
    end
    authorize @entries
  end

  def show
    # The crud.coffee widget needs this in order to re-load the page after edit
    response_status :success
  end

  def new
    @entry = component.klass.new
    @colors = Color.all
    authorize @entry
    render :new, layout: false
  end

  def edit
    @colors = Color.all
    render :edit, layout: false
  end

  def create
    @entry = component.klass.new(entry_params)
    if @entry.save
      flash[:success] = "#{component.name} was successfully created."
      response_status :success
      response_redirect helpers.meta_show_path(@entry, determine_namespace)
    else
      response_status :error
      render :new, layout: false
    end
  end

  def update
    if @entry.update(entry_params)
      flash[:success] = "#{component.name} was successfully updated."
      response_status :success
      redirect_back(fallback_location: admin_root_path, turbolinks: false)
    else
      response_status :error
      render :edit, layout: false
    end
  end

  def destroy
    @entry.destroy
    flash[:success] = "#{component.name} was successfully updated."
    response_status :success
    redirect_to helpers.meta_index_path determine_namespace
  end

    private
      # loads a component based the component key
      def component
        @component ||= Core::Component.new(key: params[:component])
      end

      def load_entry
        @entry = if slugged?(component.klass)
          component.klass.friendly.find(params[:id])
        else
          component.klass.find(params[:id])
        end
        authorize @entry
      end

      def entry_params
        component = Core::Component.new(key: params[:component])
        allowed_attrs = set_allowed_attrs(component)
        params.require(component.classpath).permit(*allowed_attrs)
      end

      # sets the allowed attributes based on the component configuration
      def set_allowed_attrs(component)
        fields = component.view("new")
        allowed_attrs = %i[id]
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
