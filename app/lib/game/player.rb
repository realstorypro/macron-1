# frozen_string_literal: true

module Game
  class Player

    def initialize(player)
      @player = player
    end

    # returns the current player state
    def state
      state = []

      # iterate through all of the paths
      all_paths.each do |path|
        current_path = OpenStruct.new
        current_path.name = path[0].to_s

        # get points
        current_path.points = points(current_path.name)

        # get level
        current_path.level = get_level(current_path.points)

        state << current_path
      end

      # collect spells appropriate for the level
      state.each do |path|
        path.spells = []
        s("spells.#{path.name}").each do |spell|
          path.spells << spell if spell[1].level <= path.level
        end
      end

      state
    end

    # returns paths and points for a given user
    # path may be passed as a filter
    def points(path = nil)
      return false unless path_exists?(path)

      return @player.score_points(category: path).sum(:num_points) if path
      @player.score_points.sum(:num_points)
    end

    # adds points to the user
    # returns the new point value for the passed path
    def add_points(path, amount)
      return false unless path_exists?(path)

      @player.add_points(amount, category: path)
    end

    # subtracts points from the user
    def subtract_points(path, amount)
      return false unless path_exists?(path)

      @player.subtract_points(amount, category: path)
    end

    # returns all of the supporters the user has
    def supporters
      @player.user_followers
    end

    def supporters_count
      @player.followers_by_type_count('User')
    end

    # adds a supporter to the user
    def add_supporter(supporter)
      supporter.follow(@player)
    end

    # remove a supporter to the user
    def remove_supporter(supporter)
      supporter.stop_following(@player)
    end


    # returns all available spells
    # @param [Object] player's path
    def available_spells?(path = nil)
      spells = []

      current_state = state
      current_state.each do |path|
        path.spells.each { |spell| spells << spell }
      end

      spells
    end

    # a spell authorization method
    def can_cast?

    end

    # casts a spell on a subject
    def cast_spell!(subject, spell)

    end

    # removes a spell from a subject
    def remove_spell!(subject, spell)

    end

    private

    # checks whether path actually exists
    # todo: finalize it onces we figre out the structure
    def path_exists?(path)
      true
    end

    # returns all available paths
    def all_paths
      s('paths')
    end

    # returns the level based on the amount of points
    def get_level(points)
      current_level = 0

      s('levels').each do |level|
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
