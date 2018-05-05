import Utils from '../core/utils'
import ahoy from 'ahoy.js'

utils =  new Utils

class ConversionTracker
  instance = null

  constructor: ->
    if !instance then instance = this
    return instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'conversion_tracker'

    $('[data-tracked-click]').on 'click', (e) ->
      event = $(@).data('event')
      name =  $(@).data('name')
      id =  $(@).data('id')
      page = window.location.pathname
      url = window.location.href

      ahoy.track event, {name, id, page, url}
      analytics.track(event, {name, id, page, url})

  teardown: () ->
    utils.log 'teardown', 'teardown()', 'conversion_tracker'
    $('[data-tracked-click]').off()


export { ConversionTracker as default }
