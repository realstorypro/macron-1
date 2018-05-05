import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'

utils =  new Utils
vent = new Vent

class Cover
  instance = null
  app = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

    vent.channel().on "vue:cover", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'cover'

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      props:
        overlay: ''
        image: ''


      mounted: ->
        @image = $(@.$options.el).find('.image')
        @overlay = $(@.$options.el).find('.overlay')

        image_url =  $(@.$options.el).data('image')
        @image.css('background-image', "url(#{image_url})")

        @resize()

        this.$nextTick =>
          window.addEventListener 'resize', @resize


      methods:
        resize: ->
          parent = $(@.$options.el).parent()
          width = parent.width()
          height = parent.outerHeight()

          @image.css('width',width)
          @image.css('height',height)
          @image.css('opacity',1)

          @overlay.css('width',width)
          @overlay.css('height',height)


export { Cover as default }
