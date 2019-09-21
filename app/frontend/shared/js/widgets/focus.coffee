import Utils from '../core/utils'
import Vent from '../core/vent'

utils = new Utils
vent = new Vent

class Focus
  instance = null

  constructor: ->
    if !instance
      instance = this

      vent.channel().on "widget:focus", (options, href, context) =>
        switch options['action']
          when 'focus' then @focus(options, href, context)


      # extending jquery with toggling function
      $.fn.extend
        toggleText: (a, b) ->
          @text(if @text() == b then a else b)

    else
      instance


  focus: (options, href, context) ->
    $('.side.nav.fragment').toggle('display')
    $('#admin-details').toggle('display')
    $('.breadcrumb').toggle()
    $('#help-button').toggle()
    $('#delete-button').toggle()
    $('#edit-button').toggle()
    $('#desktop-browser-preview').toggleClass('hidden')
    $('#mobile-browser-preview').toggleClass('hidden')
    $('#focus-mode').toggleText('Writer Mode','Exit Writer Mode')

  setup: ->
    utils.log 'setup', 'setup()', 'focus'

  teardown: ->
    utils.log 'teardown', 'teardown()', 'focus'


export { Focus as default }

