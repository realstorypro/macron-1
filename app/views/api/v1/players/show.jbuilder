json.username current_user.username
json.level @player.state.level
json.points @player.state.points

json.paths do
  json.array! @player.state.paths.each do |path|
    json.path path.name
    json.points path.points
    json.level path.level
  end
end

json.spells do
  json.array! @player.state.spells.each do |path|
    json.access_key path[0]
    json.name path[1].name
    json.icon path[1].icon
    json.level path[1].level
    json.points do
      json.low @player.get_points_range(path[1].points, path[1].level, :low)
      json.high @player.get_points_range(path[1].points, path[1].level, :high)
    end
    json.energy path[1].energy
    json.direction path[1].direction
    json.castTime path[1].castTime
  end
end
