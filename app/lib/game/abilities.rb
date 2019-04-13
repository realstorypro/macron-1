# frozen_string_literal: true

module Game::Abilities
  # returns all available spells
  # @param [Object] player's path
  def available_abilities?(progression_path = nil)
    abilities = []

    current_state = state
    current_state.each do |path|
      path.abilities.each { |ability| abilities << ability }
    end

    abilities
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

end
