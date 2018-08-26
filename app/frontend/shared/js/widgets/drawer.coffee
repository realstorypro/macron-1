import Utils from '../core/utils'
import Vent from '../core/vent'
import _ from 'underscore'

utils = new Utils
vent = new Vent

class Drawer
  instance = null

  active_sidebar = null

  constructor: ->
    if !instance
      instance = this

      vent.channel().on "widget:drawer", (options) =>

        switch options['action']
          when 'toggle_menu' then @toggle_menu(options)
          when 'open' then @open(options)
          when 'update' then @update(options)
          when 'close' then @close(options)

    instance

  toggle_menu: (options={}) ->
    defaults =
      position: "left"
      selector: null

    _.defaults(options, defaults)

    # close all open notifications
    vent.channel().trigger "widget:notification",
      action: "close_all"

    sidebar = $(".drawer.sidebar.#{options.position}")

    # convert selector to html if option is passed
    if options.selector?
      options.html = $(options.selector).html()

      vent.channel().trigger "render",
        action: "update"
        element: sidebar.selector
        html: options.html

    sidebar.sidebar('toggle')

  open: (options={}) ->
    defaults =
      position: "right"

    _.defaults(options, defaults)

    sidebar = $(".drawer.sidebar.#{options.position}")
    sidebar.dimmer('show')
    sidebar.find('.dimmer').addClass('inverted').html('<div class="ui loader text">Loading</div>')
    sidebar.find('.inside').empty()

    sidebar.sidebar 'setting', 'onChange', ->
      if active_sidebar?
        active_sidebar = null
      else
        active_sidebar = ".drawer.sidebar.#{options.position}"

    sidebar.sidebar('toggle')

  update: (options={}) ->

    defaults =
      html: null

    _.defaults(options, defaults)

    # close all open notifications
    vent.channel().trigger "widget:notification",
      action: "close_all"

    $(active_sidebar).dimmer 'hide'
    vent.channel().trigger "render",
      action: "update"
      element: "#{active_sidebar} .inside.drawer"
      html: options.html

  close: (options={}) ->
    $(active_sidebar).sidebar('hide')

export { Drawer as default }
