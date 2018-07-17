import Utils from '../core/utils'
import Vent from '../core/vent'

utils = new Utils
vent = new Vent

class Clicker
  instance = null

  constructor: ->
    if !instance
      instance = this

      vent.channel().on "widget:clicker", (options, href, context) =>

        switch options['action']
          when 'click' then @click(options, href, context)

    else
      instance


  click: (options, href, context) ->
    $(context).addClass('loading')

    $.ajax
      url: href
      type: "GET"
      success: (data, textStatus, jqXHR) =>
        vent.channel().trigger "render",
          action: "refresh"
          html: data
        Turbolinks.clearCache()

      error: (jqXHR, textStatus, errorThrown) ->
        console.log "call error", jqXHR, textStatus

  setup: ->
    utils.log 'setup', 'setup()', 'help'

  teardown: ->
    utils.log 'teardown', 'teardown()', 'help'


export { Clicker as default }

