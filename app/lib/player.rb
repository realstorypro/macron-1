# frozen_string_literal: true

class Player
  # returns all traits and points for a given user
  def self.traits(user)
    user
  end

  # returns all available spells
  def available_spells?

  end

  # a spell authorization method
  def can_cast?(user)

  end

  def cast_spell!(user, subject, spell)

  end

  def remove_spell!(user, subject, spell)

  end

  def level_up(user, trait)

  end

end
