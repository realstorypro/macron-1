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
    # Focusable
    $('.focusable').toggleClass('focused')

    # Hiding Sidebar
    $('.side.nav.fragment').toggle('display')

    # Hiding The Admin Details
    $('#admin-details').toggle('display')

    # Hiding Distracting Buttons
    $('#delete-button').toggle()
    $('#edit-button').toggle()

    # Toggle the Action Bar Width
    $('.action.bar .ui.right').toggleClass(('full-width'))

    # Toggle Focus Text
    $('#focus-mode').toggleText('Enter Writer Mode','Exit Writer Mode')

    # Toggle Entry Details
    $('.entry.details').slideToggle()

    # Toggle Page Builder
    $('.page.builder').toggleClass('active')

    vent.channel().trigger "widget:sorter", action: "toggle"

  setup: ->
    utils.log 'setup', 'setup()', 'focus'

  teardown: ->
    utils.log 'teardown', 'teardown()', 'focus'


export { Focus as default }

