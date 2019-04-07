import Utils from '../core/utils'

utils =  new Utils

class Sticky
  instance = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'sticky'


    $(".widget.sticky").each (index, item) ->
      random_id =  Math.floor(Math.random() * 100)

      $(item).find('.context').attr('id', "stuckable_#{random_id}")
      $(item).find('.ui.sticky').sticky
        context: "#stuckable_#{random_id}"
        offset: 120

    # TODO: Maybe we should turn this into an event call
    setTimeout ( ->
      $('.ui.sticky').sticky('refresh')
    ), 500



  teardown: () ->
    utils.log 'teardown', 'teardown()', 'sticky'

export { Sticky as default }
