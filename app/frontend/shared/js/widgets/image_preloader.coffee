import Utils from '../core/utils'

utils =  new Utils

class ImagePreloader
  instance = null

  constructor: ->
    @first_load = true

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

    if @first_load
      window.onload = @load_images()

      # show the dimmer when switching off things
      document.addEventListener 'turbolinks:before-cache', ->
        $('[data-src] .ui.dimmer').dimmer('show')

      @first_load = false
    else
      @load_images()




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

      # make things progressive
      image_src = image_src + "-/progressive/yes/"

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
