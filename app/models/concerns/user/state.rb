# frozen_string_literal: true

module User::State
  extend ActiveSupport::Concern


  included do
    # @param [String] progression_path a filter for the progression path
    # @return [Object] the current state of the player
    def state(progression_path = nil)
      unless @state
        @state = OpenStruct.new
        @state.points = get_points(progression_path)
        @state.level = get_level(state.points)
        @state.max_energy = get_max_energy(state.level)
        @state.paths = get_paths(progression_path)
        @state.spells = get_spells(progression_path)
      end
      @state
    end

    # casts a spell onto a subject and passes points on a user associated
    # with the subject
    # @param [Symbol] spell_name the name of the spell
    # @param [Object] subject an object with an attached user to perform a spell on
    def cast_spell!(spell_name, subject)
      return false unless can_cast?(spell_name)
      # get the spell details
      castable_spell = get_spell_details(spell_name)

      # short cirtucit if there isn't enogh energy
      return false if self.energy <= castable_spell.energy

      # get points
      castable_points = get_castable_points(castable_spell)

      # add the spell on the subject
      if castable_spell.direction == "positive"
        subject.vote_by voter: self, vote: "like", vote_scope: spell_name, vote_weight: castable_points, duplicate: true
      else
        subject.vote_by voter: self, vote: "bad", vote_scope: spell_name, vote_weight: castable_points, duplicate: true
      end

      # add the points the castable owner
      if castable_spell.direction == "positive"
        subject.user.add_game_points(castable_spell.path, castable_points)
      else
        subject.user.subtract_game_points(castable_spell.path, castable_points)
      end

      # reduce the available energy
      self.energy = self.energy - castable_spell.energy
      self.save

      castable_points
    end

    # @param [String] progression_path a filter for the progression path
    # @return [Integer] a summation of points
    def get_points(progression_path = nil)
      return false unless path_exists?(progression_path)

      return self.score_points(category: progression_path).sum(:num_points) if progression_path
      self.score_points.sum(:num_points)
    end

    # @param [Integer] spell_points the number of points the spell is worth
    # @param [Integer] path_level of the path
    # @param [Symbol] range lower of high range
    # @return [Integer] points for the give range
    def get_points_range(spell_points, path_level, range)
      case range
      when :low
        (spell_points * path_level) / 2
      when :high
        (spell_points * path_level) * 2
      end
    end

    # @param [Object] spell for which the calculation is performed
    # @return [Integer] number of points ot be cast
    def get_castable_points(spell)
      low = get_points_range(spell.base_points, spell.spell_level, :low)
      high = get_points_range(spell.base_points, spell.spell_level, :high)
      rand(low...high)
    end

    # adds points to the user
    # @return [Boolean] returns true if operation is successful
    def add_game_points(path, amount)
      return false unless path_exists?(path)

      self.add_points(amount, category: path)
      true
    end

    # subtracts points from the user
    # @return [Boolean] returns true if operation is successful
    def subtract_game_points(path, amount)
      return false unless path_exists?(path)

      self.subtract_points(amount, category: path)
      true
    end

    # regenerates energy for the user based on their level
    def regenerate_energy
      self.energy = get_max_energy(self.state.level)
      self.save
    end

    private
      # returns the level based on the amount of points
      # @param [Integer] number_of_points number of points
      # @return [Integer] a level for the number of points
      def get_level(number_of_points)
        current_level = 1

        s("levels").each do |level|
          current_level = level[0].to_s.to_i if level[1].points < number_of_points
        end

        current_level
      end

      # returns the maximum amount of energy for the level
      def get_max_energy(level)
        s("levels.#{level}").energy
      end

      # checks whether path actually exists
      # @param [String] progression_path a filter for the progression path
      def path_exists?(progression_path)
        s("paths.#{progression_path}")
        true
      end

      # returns all available paths
      # @param [String] progression_path a filter for the progression path
      def get_paths(progression_path = nil)
        paths = s("paths") unless progression_path
        paths = s("paths.#{progression_path}") if progression_path

        path_arr = []

        paths.each do |path|
          path_obj = OpenStruct.new
          path_obj.name = path[0].to_s

          # get points
          path_obj.points = get_points(path_obj.name)

          # get level
          path_obj.level = get_level(path_obj.points)

          path_obj.skill = path[1].skill
          path_obj.icon = path[1].icon

          path_arr << path_obj
        end

        # ensures that the highest level paths are shown first
        path_arr.sort! { |a, b| b.level <=> a.level }
      end


      # returns all available spells
      # @param [String] progression_path a filter
      def get_spells(progression_path = nil)
        spells = []

        s("spells").each do |spell|
          spell_level = get_level get_points(spell[1].path)
          next if progression_path && spell[1].path != progression_path
          if spell[1].level <= spell_level
            spell[1].spell_level = spell_level
            spells << spell
          end
        end
        spells
      end

      # a spell authorization method
      # @param [String] spell to be cast
      # @return [Boolean] returns true if the spell can be cast and false if it cant
      def can_cast?(spell)
        get_spells.each do |available_spell|
          return true if available_spell[0] == spell
        end
        false
      end

      # returns a singular spell object
      def get_spell_details(spell)
        get_spells.each { |current_spell| return current_spell[1] if current_spell[0] == spell }
      end
  end
end
