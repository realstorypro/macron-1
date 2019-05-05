# frozen_string_literal: true

class API::V1::PlayersController < ApplicationController
  # returns  the profile of the player
  def show
    @player = Game::Player.new(current_user)
  end

  private
end
