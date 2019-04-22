# frozen_string_literal: true

module Game::Paths
  private

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

      path_arr << path_obj
    end

    path_arr
  end
end
