import Utils from '../core/utils'

utils =  new Utils

class ImagePreloader
  instance = null

  constructor: ->
    @event_added = false

    if !instance
      instance = this

    else
      instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'image_preloader'

    # Setting Dimmer as Active
    $('[data-src] .ui.dimmer').dimmer('set dimmed', true)


    # TODO: this is a bit hacky. We want to refactorit later
    # we're using event_added to ensure that
    # we only add the event once
    unless @event_added
      window.onload = @load_images()

      window.addEventListener 'turbolinks:load', =>
        @load_images()

      # Unload Images Before Cache
      document.addEventListener 'turbolinks:before-cache', ->
        $('[data-src]').each (index,  value) ->
          item = $(value)
          item.css('background-image', '')

        $('[data-src] .ui.dimmer').dimmer('show')

      @event_added = true


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'image_preloader'

  load_images: () ->
    $('[data-src]').each (index,  value) ->

      if (typeof navigator.connection == 'undefined') || navigator.connection.downlink > 2.5
        container_height = Math.ceil($(@).height()) * 2
      else
        container_height = Math.ceil($(@).height())

      item = $(value)
      image_src = item.data('src')

      resize = image_src.match(/\/resize\/[^/]*\//g)

      # resize the resize if it exists or append it
      if resize
        image_src = image_src.replace(/\/resize\/[^/]*\//g, "/resize/x#{container_height}/")
      else
        image_src = image_src + "-/resize/x#{container_height}/"

      image_css_src = "url(#{image_src})"
      image_klass = item.data('klass')


      preloaded_image = new Image()
      preloaded_image.src = image_src

      image_loaded = =>
        item.css('background-image', image_css_src)
        item.addClass(image_klass)
        item.find('.dimmer').dimmer('hide')

      preloaded_image.onload = image_loaded



export { ImagePreloader as default }
