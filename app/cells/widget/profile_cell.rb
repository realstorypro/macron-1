# frozen_string_literal: true

include ActionView::Helpers::NumberHelper

module Widget
  class ProfileCell < BaseCell
    def show
      @member = options[:user]
      @player = Game::Player.new(options[:user])
      render(options[:layout])
    end
  end
end
