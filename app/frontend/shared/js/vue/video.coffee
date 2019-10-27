import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'

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

    @app = new Vue
      el: "##{widget.id}"
      data:
        options:
          controls: ['play-large', 'progress', 'current-time', 'mute', 'volume', 'pip', 'settings']
      mounted: ->
        # utilizng the next tick
        # per this https://github.com/redxtech/vue-plyr/issues/54

        @.$nextTick ->
          video_player = document.getElementById("player_#{widget.id}")
          video_player.addEventListener 'ready', =>
          
            # remove the cover on ready
            @cover_element = $("#{@.$options.el} .cover")
            @cover_element.animate {
              opacity: 0
            },300, =>
              @cover_element.hide()

            @player = @.$refs["#{widget.id}"].player

            # braodcast the video being played on play
            @player.on 'play', =>
              vent.channel().trigger "playing:video", widget.id

            # stop playing video and turn off pip if another video is playing
            vent.channel().on "playing:video", (video) =>
              if video != widget.id
                @player.pip = false
                @player.stop()

      beforeDestroy: ->
        player = @.$refs["#{widget.id}"].player
        player.pip = false



export { Video as default }
