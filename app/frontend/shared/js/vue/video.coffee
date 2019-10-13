import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'

utils = new Utils
vent = new Vent

class Video
  instance = null
  app = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

    vent.channel().on "vue:video", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'video'
    console.log widget

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      data:
        options:
          controls: ['play-large', 'progress', 'current-time', 'mute', 'volume', 'pip', 'settings']
      computed:
        player: ->
          @.$refs["#{widget.id}"].player
      mounted: ->
        @player.on 'ready', =>
          @cover_element = $("#{@.$options.el} .cover")
          @cover_element.animate {
            opacity: 0
          },300, =>
            @cover_element.hide()


export { Video as default }
