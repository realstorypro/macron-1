json.username @user.username
json.avatar @user.profile.avatar
json.first_name @user.profile.first_name
json.last_name @user.profile.last_name
json.level @player.state.level
json.points @player.state.points

json.job @user.profile.job
json.education @user.profile.education

json.supporters @player.supporters_count

json.paths do
  json.array! @player.state.paths.each do |path|
    json.path path.name
    json.skill path.skill
    json.points path.points
    json.level path.level
    json.icon path.icon
  end
end

json.spells do
  json.array! @player.state.spells.each do |path|
    json.access_key path[0]
    json.name path[1].name
    json.icon path[1].icon
    json.level path[1].level
    json.color path[1].color
    json.description path[1].description
    json.points do
      json.low @player.get_points_range(path[1].points, path[1].level, :low)
      json.high @player.get_points_range(path[1].points, path[1].level, :high)
    end
    json.energy path[1].energy
    json.direction path[1].direction
    json.castTime path[1].castTime
  end
end
