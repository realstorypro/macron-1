import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import axios from 'axios'

utils = new Utils
vent = new Vent

class Consent
  instance = null
  app = null

  constructor: ->
    if !instance
      instance = this
    else

    vent.channel().on "vue:consent", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'consent'

    @app = new Vue
      el: "##{widget.id}"
      mounted: ->
        console.log 'consent loaded'
      methods:
        accept: ->
          console.log 'i accept'

export { Consent as default }

