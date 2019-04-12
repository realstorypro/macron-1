# frozen_string_literal: true

module Game
  class Player

    def initialize(options = {})

    end

    # returns paths and points for a given user
    # path may be passed as a filter
    def points(player, path = nil)
      return false unless path_exists?(path)

      return player.score_points(category: path).sum(:num_points) if path
      player.score_points.sum(:num_points)
    end

    # adds points to the user
    # returns the new point value for the passed path
    def add_points(player, path, amount)
      return false unless path_exists?(path)

      player.add_points(amount, category: path)
      points(player, path)
    end

    # subtracts points from the user
    def subtract_points(player, path, amount)
      return false unless path_exists?(path)

      player.subtract_points(amount, category: path)
      points(player, path)
    end

    # returns all of the supporters the user has
    def supporters(player)
      player.user_followers
    end

    def supporters_count(player)
      player.followers_by_type_count('User')
    end

    # adds a supporter to the user
    def add_supporter(player, supporter)
      supporter.follow(player)
    end

    # remove a supporter to the user
    def remove_supporter(player, supporter)
      supporter.stop_following(player)
    end


    # returns all available spells
    def available_spells?(player)
      path_state = []

      all_paths.each do |path|
        points = OpenStruct.new
        points.name = path[0].to_s

        # get points
        points.points = points(player, points.name)

        # get level
        points.level = get_level(points.points)

        # get spells appropriate for the level

        path_state << points
      end

      path_state

      spells = []
      path_state.each do |path|
        path.spells = []
        s("spells.#{path.name}").each do |spell|
          path.spells << spell if spell[1].level <= path.level
        end
      end

      path_state
    end

    # a spell authorization method
    def can_cast?(user)

    end

    # casts a spell on a subject
    def cast_spell!(user, subject, spell)

    end

    # removes a spell from a subject
    def remove_spell!(user, subject, spell)

    end

    def level_up(user, trait)

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
