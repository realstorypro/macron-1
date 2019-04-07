import Utils from '../core/utils'
import Vent from '../core/vent'

utils =  new Utils
vent =  new Vent

class Sticky
  instance = null

  constructor: ->
    if !instance
      instance = this

      vent.channel().on "sticky", (options) =>
        switch options['action']
          when 'refresh' then @refresh(options)

    instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'sticky'


    unless utils.is_mobile()

      $(".widget.sticky").each (index, item) ->
        random_id =  Math.floor(Math.random() * 100)

        $(item).find('.context').attr('id', "stuckable_#{random_id}")
        $(item).find('.ui.sticky').sticky
          context: "#stuckable_#{random_id}"
          offset: 90


  refresh: () ->
    unless utils.is_mobile()
      setTimeout ( ->
        $('.ui.sticky.refreshing').sticky('refresh')
      ), 1

  teardown: () ->
    utils.log 'teardown', 'teardown()', 'sticky'

export { Sticky as default }
