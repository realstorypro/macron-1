# frozen_string_literal: true

class API::V1::PlayersController < ApplicationController
  # returns  the profile of the player
  def show
    if params[:id]
      @user = User.find([params[:id]]).first
    else
      @user = current_user
    end
  end

  def cast
    subject = if slugged?(entry_class)
      entry_class.friendly.find(params[:subject_id])
    else
      entry_class.find(params[:subject_id])
    end

    current_user.cast_spell!(params[:spell].to_sym, subject)
  end

  def support
    current_user.support(User.find(params[:id]))
    head 200
  end

  def stop_supporting
    current_user.stop_supporting(User.find(params[:id]))
    head 200
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
