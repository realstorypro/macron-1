import Utils from './utils'
import Vent from './vent'

utils = new Utils
vent = new Vent

class Common
  instance = null
  app = null

  constructor: (@event_name) ->
    if !instance
      instance = this
      @register_events()

    else
      instance

  register_events: ->
    utils.log 'setup', 'setup()', 'social_sharing'

    vent.channel().on "vue:#{@event_name}", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

export { Common as default }
