# frozen_string_literal: true

module Game
  class Player
    include Game::Paths
    include Game::Points
    include Game::Spells

    def initialize(player)
      @player = player
    end

    # @param [String] progression_path a filter for the progression path
    # @return [Object] the current state of the player
    def state(progression_path = nil)
      state = OpenStruct.new
      state.points = get_points(progression_path)
      state.level = get_level(state.points)
      state.paths = get_paths(progression_path)
      state.spells = get_spells(progression_path)
      state
    end

    private

      # returns the level based on the amount of points
      # @param [Integer] points number of points
      # @return [Integer] a level for the number of points
      def get_level(points)
        current_level = 0

        s("levels").each do |level|
          current_level = level[0].to_s.to_i if level[1] < points
        end

        current_level
      end

    # shortcut for settings
    def s(path)
      SettingProxy.instance.s(path)
    end

  end
end
