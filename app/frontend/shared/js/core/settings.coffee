class Settings
  instance = null
  env = {}

  # implementing singleton pattern
  constructor : () ->
    if !instance then instance = this
    return instance

  # sets the value of the property
  set: (property) ->
    env = Object.assign(env, property)

  # returns the vlaue of the property
  get: (property) ->
    env[property]

  # checks if the property is on
  on: (property) ->
    if env[property]? and env[property] is true
      true
    else
      false

  # checks if the property exists
  in: (property) ->
    if env[property]?
      true
    else
      false

export { Settings as default}
