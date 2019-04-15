# frozen_string_literal: true

module Game
  class Player
    include Game::Supporters
    include Game::Points
    include Game::Spells

    def initialize(player)
      @player = player
    end

    # @return [Object] the current state of the player
    # @param [Object] allows to filter the state by path
    def state(progression_path = nil)
      state = OpenStruct.new
      state.points = get_points(progression_path)
      state.paths = get_paths(progression_path)
      state.spells = get_spells(progression_path)
      state
    end

    private

      # checks whether path actually exists
      def path_exists?(progression_path)
        s("paths.#{progression_path}")
        true
      end

      # returns all available paths
      # @param [String] progression_path a filter
      def get_paths(progression_path = nil)
        paths = s("paths") unless progression_path
        paths = s("paths.#{progression_path}") if progression_path

        path_colletion = []

        paths.each do |path|
          path_obj = OpenStruct.new
          path_obj.name = path[0].to_s

          # get points
          path_obj.points = get_points(path_obj.name)

          # get level
          path_obj.level = get_level(path_obj.points)

          path_colletion << path_obj
        end

        path_colletion
      end


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
