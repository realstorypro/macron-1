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

        @regular =  $(@.$options.el).data('image')
        @landscape =  $(@.$options.el).data('landscape-image')
        @vertical =  $(@.$options.el).data('vertical-image')

        @set_image_source()
        @resize()

        this.$nextTick =>
          #window.addEventListener 'resize', @resize
          window.addEventListener 'resize', =>
            @set_image_source()
            @resize()


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

        # we want to be able to simply pass an image and not worry about vertical vs landscape
        # if we do pass both vertical and landscape images we want the mto switch based the size
        set_image_source: ->
          if @regular
            @image.css('background-image', "url(#{@regular})")
          else
            if utils.is_mobile()
              @image.css('background-image', "url(#{@vertical})")
            else
              @image.css('background-image', "url(#{@landscape})")



export { Cover as default }
