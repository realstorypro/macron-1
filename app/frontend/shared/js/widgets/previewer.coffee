import Utils from '../core/utils'
import Vent from '../core/vent'

utils = new Utils
vent = new Vent

class Previewer
  instance = null

  constructor: ->
    if !instance
      instance = this

      vent.channel().on "widget:previewer", (options, href, context) =>
        switch options['action']
          when 'preview' then @preview(options, href, context)

    else
      instance


  preview: (options, href, context) ->
    console.log 'prereview', options, href, context
    $(".ui.preview.modal")
      .modal
        onShow: ->
          $(".ui.preview.modal iframe").attr('src', context + "?preview=#{Date.now()}")
          $(".ui.preview.modal iframe").attr('height', $(window).height() - 100)
        onHide: ->
          $(".ui.preview.modal iframe").attr('src', '')
      .modal('show')

  setup: ->
    utils.log 'setup', 'setup()', 'previewer'

  teardown: ->
    utils.log 'teardown', 'teardown()', 'previewer'


export { Previewer as default }

