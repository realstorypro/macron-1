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


        setTimeout (->
          context_height = $(item).find('.context').height()
          sticky_height = $(item).find('.ui.sticky').height()

          unless sticky_height > context_height
            # Activate Sticky If Necessery
            $(item).find('.context').attr('id', "stuckable_#{random_id}")
            $(item).find('.ui.sticky').sticky
              context: "#stuckable_#{random_id}"
              offset: 90
              observeChanges: true
              onBottom: () ->
              # hacky fix to stuck column having incorrect width
                parent = $(item).find('.ui.sticky').parent()
                bottom_width = parent.width()
                $(item).find('.ui.sticky').css('width', "#{bottom_width}px")
        ), 2000




  teardown: () ->
    utils.log 'teardown', 'teardown()', 'sticky'

export { Sticky as default }
