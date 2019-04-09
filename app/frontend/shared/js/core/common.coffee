import Utils from './utils'
import Vent from './vent'

utils = new Utils
vent = new Vent

class Common
  instance = null
  app = null

  constructor: (@event_name) ->
    @register_events()

  register_events: ->
    vent.channel().on "vue:#{@event_name}", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

export { Common as default }
