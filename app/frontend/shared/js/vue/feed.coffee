import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'

utils = new Utils
vent = new Vent

class Feed
  instance = null
  app = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

    vent.channel().on "vue:feed", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'feed'

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]

export { Feed as default }