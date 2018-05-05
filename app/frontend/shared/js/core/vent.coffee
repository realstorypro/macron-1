import Utils from './utils'
import backbone from 'backbone'
import _ from 'underscore'

utils =  new Utils

# used for in-app communication
class Vent

  instance = null
  channel = null

  # implementing singleton pattern
  constructor : () ->
    if !instance then instance = this
    instance

  channel: () ->
    if !channel
      channel = {}
      _.extend(channel, backbone.Events)
    channel

export { Vent as default}
