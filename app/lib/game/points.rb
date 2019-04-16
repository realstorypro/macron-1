# frozen_string_literal: true

module Game::Points
  # adds points to the user
  # @return [Boolean] returns true if operation is successful
  def add_points(path, amount)
    return false unless path_exists?(path)

    @player.add_points(amount, category: path)
    true
  end

  # subtracts points from the user
  # @return [Boolean] returns true if operation is successful
  def subtract_points(path, amount)
    return false unless path_exists?(path)

    @player.subtract_points(amount, category: path)
    true
  end

  # @param [String] progression_path a filter for the progression path
  # @return [Integer] a summation of points
  def get_points(progression_path = nil)
    return false unless path_exists?(progression_path)

    return @player.score_points(category: progression_path).sum(:num_points) if progression_path
    @player.score_points.sum(:num_points)
  end
end
