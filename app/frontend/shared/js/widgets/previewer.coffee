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
          when 'desktop' then @desktop(options, href, context)
          when 'mobile' then @mobile(options, href, context)

    else
      instance


  desktop: (options, href, context) ->
    $(".ui.preview.modal")
      .modal
        onShow: ->
          $(".ui.preview.modal iframe").attr('src', context + "?preview=#{Date.now()}")
          $(".ui.preview.modal iframe").attr('height', $(window).height() - 100)
        onHide: ->
          $(".ui.preview.modal iframe").attr('src', '')
      .modal('show')

  mobile: (options, href, context) ->
    $(".ui.preview.modal")
      .modal
        onShow: ->
          $(".ui.preview.modal").removeClass('fullscreen')
          $(".ui.preview.modal").css('width', '450px')
          $(".ui.preview.modal iframe").attr('src', context + "?preview=#{Date.now()}")
          $(".ui.preview.modal iframe").attr('height', $(window).height() - 100)
        onHide: ->
          $(".ui.preview.modal iframe").attr('src', '')
        onHidden: ->
          $(".ui.preview.modal").css('width', '450px')
          $(".ui.preview.modal").addClass('fullscreen')
          $(".ui.preview.modal iframe").attr('src', '')
      .modal('show')

  setup: ->
    utils.log 'setup', 'setup()', 'previewer'

  teardown: ->
    utils.log 'teardown', 'teardown()', 'previewer'


export { Previewer as default }

