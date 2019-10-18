import Utils from '../core/utils'
import ahoy from 'ahoy.js'

utils =  new Utils

class ViewTracker
  instance = null

  constructor: ->
    if !instance then instance = this
    return instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'view_tracker'
    $('[data-tracked-page').each ->
      event = $(@).data('event')
      props = $(@).data('props')
      ahoy.track event, props

  teardown: () ->
    utils.log 'teardown', 'teardown()', 'view_tracker'


export { ViewTracker as default }
