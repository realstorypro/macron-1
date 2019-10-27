import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'

utils = new Utils
vent = new Vent

class Audio
  instance = null
  app = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

    vent.channel().on "vue:audio", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'video'

    @app = new Vue
      el: "##{widget.id}"
      mounted: ->
        @cover_element = $("#{@.$options.el} .cover")
        $("#{@.$options.el} iframe").on 'load', =>
          @cover_element.animate {
             opacity: 0
           },300, =>
            @cover_element.hide()

export { Audio as default }