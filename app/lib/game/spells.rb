# frozen_string_literal: true

module Game::Spells
  # casts a spell on a subject
  def cast_spell!(spell, subject)
    return false unless can_cast?(spell)
    # find second player
    player2 = Game::Player.new(subject.user)

    # get the spell details
    castable = get_spell(spell)

    # add the spell on the subject
    if castable.direction == 'positive'
      subject.vote_by voter: @player, vote: "like", vote_scope: spell, vote_weight: castable.points, :duplicate => true
    else
      subject.vote_by voter: @player, vote: "bad", vote_scope: spell, vote_weight: castable.points, :duplicate => true
    end

    # add the points the castable owner
    if castable.direction == 'positive'
      player2.add_points(castable.path, castable.points)
    else
      player2.subtract_points(castable.path, castable.points)
    end

    true
  end

  # removes a spell from a subject
  def undo_spell!(spell, subject)
    return false unless can_cast?(spell)
    # find second player
    player2 = Game::Player.new(subject.user)

    # get the spell details
    castable = get_spell(spell)

    # remove spell from the subject
    subject.unvote voter: @player, vote_scope: spell

    # add the points the article owner
    player2.subtract_points(castable.path, castable.points)
  end

  # returns all available spells
  # @param [String] progression_path a filter
  def get_spells(progression_path = nil)
    spells = []

    s("spells").each do |spell|
      path_level = get_level get_points(spell[1].path)
      next if progression_path && spell[1].path != progression_path
      spells << spell if spell[1].level <= path_level
    end
    spells
  end

  private

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
    def get_spell(spell)
      get_spells.each { |current_spell| return current_spell[1] if current_spell[0] == spell }
    end

end