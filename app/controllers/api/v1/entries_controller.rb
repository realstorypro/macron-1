# frozen_string_literal: true

class API::V1::EntriesController < ApplicationController
  # returns the world state for the entry
  def show
    @entry = entry_class.find(params[:id])
  end

  # returns the entry class
  def entry_class
    @entry_class ||= settings("components.#{params[:component]}.klass", fatal_exception: true).classify.constantize
  end

  # checks if the entry has a slug
  def slugged?(entry)
    entry.column_names.include? "slug"
  end
end
