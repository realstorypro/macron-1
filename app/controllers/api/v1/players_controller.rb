# frozen_string_literal: true

class API::V1::PlayersController < ApplicationController
  before_action :find_player
  
  # returns  the profile of the player
  def show
  end

  def cast
    subject= if slugged?(entry_class)
      entry_class.friendly.find(params[:subject_id])
    else
      entry_class.find(params[:subject_id])
    end

    @player.cast_spell!(params[:spell].to_sym, subject)
  end

  private
  def find_player
    @player = Game::Player.new(current_user)
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
