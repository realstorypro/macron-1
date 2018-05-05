import Utils from '../core/utils'
import Vent from '../core/vent'

utils = new Utils
vent = new Vent

class Notifications
  instance = null

  constructor: ->
    if !instance
      instance = this

      vent.channel().on "widget:notification", (options, href, context) =>

        switch options['action']
          when 'close' then @close(options, href, context)
          when 'close_all' then @close_all()

    else
      instance

  close: (options, href, context) ->
    notification = $(context).parents('.message')
    notification.remove()

  close_all: ->
    $('.notifications .message .close').each ->
      $(@).trigger('click')

  setup: () ->
    utils.log 'setup', 'setup()', 'notifications'

    $('#notice .message').removeClass('off screen')
    setTimeout(this.close_all, 4000)

  teardown: () ->
    utils.log 'teardown', 'teardown()', 'notifications'

export { Notifications as default }

