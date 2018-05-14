import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'

utils = new Utils
vent = new Vent

class Sidenav
  instance = null
  app = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

    vent.channel().on "vue:sidenav", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'sidenav'

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      props:
        location: ''
      methods:
        close: () ->
          $(@.$options.el).sidebar('hide')
        visit: (url) ->
          @location = url
          @close()
        clear_location: ->
          @location = ''
        visit_location: ->
          if @location.length > 0
            Turbolinks.visit @location
      mounted: ->
        sidebar_el = $(@.$options.el)
        sidebar_el = $(@.$options.el)
        sidebar_el.sidebar('setting', 'dimPage', true)
        sidebar_el.sidebar('setting', 'transition', 'overlay')
        sidebar_el.sidebar('setting', 'mobileTransition', 'overlay')
        sidebar_el.sidebar('setting','onShow', @clear_location)
        sidebar_el.sidebar('setting','onHide', @visit_location)

export { Sidenav as default }
