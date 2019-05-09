# frozen_string_literal: true

class API::V1::PlayersController < ApplicationController
  # returns  the profile of the player
  def show
    if params[:user_id]
      @user = User.find([params[:user_id]]).first
    else
      @user = current_user
    end

    @player = Game::Player.new(@user)
  end

  def cast
    @player = Game::Player.new(current_user)

    subject = if slugged?(entry_class)
      entry_class.friendly.find(params[:subject_id])
    else
      entry_class.find(params[:subject_id])
    end

    @player.cast_spell!(params[:spell].to_sym, subject)
  end

  # returns the entry class
  def entry_class
    @entry_class ||= settings("components.#{params[:component]}.klass", fatal_exception: true).classify.constantize
  end
  #
  # checks if the entry has a slug
  def slugged?(entry)
    entry.column_names.include? "slug"
  end
end
