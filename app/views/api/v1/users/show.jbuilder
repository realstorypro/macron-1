# frozen_string_literal: true

json.username @user.username
json.avatar @user.profile.avatar
json.first_name @user.profile.first_name
json.last_name @user.profile.last_name
json.level @user.state.level
json.points @user.state.points
json.energy @user.energy
json.max_energy @user.state.max_energy

json.job @user.profile.job
json.education @user.profile.education

json.supporters @user.supporters_count

json.paths do
  json.array! @user.state.paths.each do |path|
    json.path path.name
    json.skill path.skill
    json.points path.points
    json.level path.level
    json.icon path.icon
  end
end

json.spells do
  json.array! @user.state.spells.each do |spell|
    json.access_key spell[0]
    json.name spell[1].name
    json.icon spell[1].icon
    json.level spell[1].level
    json.color spell[1].color
    json.description spell[1].description
    json.base_points spell[1].base_points
    json.spell_level spell[1].spell_level
    json.points do
      json.low @user.get_points_range(spell[1].base_points, spell[1].spell_level, :low)
      json.high @user.get_points_range(spell[1].base_points, spell[1].spell_level, :high)
    end
    json.energy spell[1].energy
    json.direction spell[1].direction
    json.castTime spell[1].castTime
  end
end
