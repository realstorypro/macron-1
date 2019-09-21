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
    # Hiding Sidebar
    $('.side.nav.fragment').toggle('display')

    # Hiding Breadcrumb and Details
    $('#admin-details').toggle('display')
    $('.breadcrumb').toggle()

    # Hiding Extra Buttons
    $('#help-button').toggle()
    $('#delete-button').toggle()
    $('#edit-button').toggle()

    # Showing the Preview Buttons
    $('#desktop-browser-preview').toggleClass('hidden')
    $('#mobile-browser-preview').toggleClass('hidden')

    # Toggling dynamic class to avoid focus mode being lost
    # once the page refreshes
    $('#header').toggleClass('dynamic')

    $('#focus-mode').toggleText('Writer Mode','Exit Writer Mode')

  setup: ->
    utils.log 'setup', 'setup()', 'focus'

  teardown: ->
    utils.log 'teardown', 'teardown()', 'focus'


export { Focus as default }

