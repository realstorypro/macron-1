import Vent from './vent'

vent = new Vent

class Common

  constructor: (event_name) ->
    @register_events(event_name)

  register_events: (event_name) ->
    vent.channel().on "vue:#{event_name}", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

export { Common as default }
