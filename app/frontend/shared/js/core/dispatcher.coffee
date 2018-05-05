import Utils from './utils'
import Vent from './vent'
import $ from 'jquery'

utils =  new Utils
vent =  new Vent


class Dispatcher
  instance = null

  # implementing singleton pattern
  constructor : () ->
    if !instance then instance = this
    return instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'dispatcher'

    $('[data-widget]').on 'click', (e) ->
      widget =  $(@).data( 'widget' )
      data = $(@).data()
      href = $(@).attr('href')
      context = @

      if widget?
        e.preventDefault()
        vent.channel().trigger "widget:#{widget}", data, href, context


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'dispatcher'
    $('[data-widget]').off 'click'

export { Dispatcher as default}