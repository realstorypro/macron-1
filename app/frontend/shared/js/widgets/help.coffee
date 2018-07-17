import Utils from '../core/utils'
import Vent from '../core/vent'

utils = new Utils
vent = new Vent

class Help
  instance = null

  constructor: ->
    if !instance
      instance = this

      vent.channel().on "widget:help", (options, href, context) =>

        switch options['action']
          when 'show' then @toggle(options, href, context)
          when 'hide' then @toggle(options, href, context)

    else
      instance


  toggle: (options, href, context) ->
    $(context).addClass('loading')

    $.ajax
      url: href
      type: "GET"
      success: (data, textStatus, jqXHR) =>
        console.log 'data', data
        vent.channel().trigger "render",
          action: "refresh"
          html: data

      error: (jqXHR, textStatus, errorThrown) ->
        console.log "call error", jqXHR, textStatus

  setup: ->
    utils.log 'setup', 'setup()', 'help'

  teardown: ->
    utils.log 'teardown', 'teardown()', 'help'


export { Help as default }

