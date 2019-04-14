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

      state.points = points()
      state.paths = []

      # iterate through all of the paths
      get_paths(progression_path).each do |path|
        path_obj = OpenStruct.new
        path_obj.name = path[0].to_s

        # get points
        path_obj.points = points(path_obj.name)

        # get level
        path_obj.level = get_level(path_obj.points)

        state.paths << path_obj
      end

      # collect spells appropriate for the level
      state.paths.each do |current_path|
        current_path.spells = []
        s("spells.#{current_path.name}").each do |spell|
          current_path.spells << spell if spell[1].level <= current_path.level
        end
      end

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
      return s("paths") unless progression_path

      s("paths.#{progression_path}")
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
