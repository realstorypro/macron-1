# frozen_string_literal: true

module Game::Spells
  # casts a spell on a subject
  def cast_spell!(spell, subject)
    return false unless can_cast?(spell)
    castable = get_spell(spell)
    subject.vote_by voter: @player, vote: "like", vote_scope: castable.spell, vote_weight: castable.points
    true
  end

  # removes a spell from a subject
  def undo_spell!(spell, subject)
    return false unless can_cast?(spell)
    castable = get_spell(spell)
    subject.unvote voter: @player, vote_scope: castable.spell
  end

  private

    # a spell authorization method
    # @param [String] spell to be cast
    # @return [Boolean] returns true if the spell can be cast and false if it cant
    def can_cast?(spell)
      available_spells.each do |available_spell|
        return true if available_spell[0] == spell
      end
      false
    end

    # returns all available spells
    # @param [Object] player's path
    def available_spells
      spells = []

      state.paths.each do |path|
        path.spells.each do |spell|
          spell[1].path = path.name
          spell[1].spell = spell[0]
          spells << spell
        end
      end

      spells
    end

    # returns a singular spell object
    def get_spell(spell)
      available_spells.each do |available_spell|
        return available_spell[1] if available_spell[0] == spell
      end
    end
end
