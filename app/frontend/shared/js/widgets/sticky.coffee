import Utils from '../core/utils'

utils =  new Utils

class Sticky
  instance = null

  constructor: ->
    if !instance
      instance = this

    instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'sticky'


    unless utils.is_mobile()

      $(".widget.sticky").each (index, item) ->
        random_id =  Math.floor(Math.random() * 100)

        # Ensures that we only adjust bottom once
        @bottomAdjusted = false

        $(item).find('.context').attr('id', "stuckable_#{random_id}")
        $(item).find('.ui.sticky').sticky
          context: "#stuckable_#{random_id}"
          offset: 90
          observeChanges: true
          onBottom: () ->
            # hacky fix to stuck column having incorrect width
            unless @bottomAdjusted
              bottom_width = $(item).find('.ui.sticky').parent().width()
              $(item).find('.ui.sticky').width(bottom_width)
              @bottomAdjusted = true



  teardown: () ->
    utils.log 'teardown', 'teardown()', 'sticky'

export { Sticky as default }
