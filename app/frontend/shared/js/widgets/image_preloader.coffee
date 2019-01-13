import Utils from '../core/utils'

utils =  new Utils

class ImagePreloader
  instance = null

  constructor: ->
    # @first_load = true

    @observer = null
    @image_count = 0
    @config =
      rootMargin: '50px 0px'
      threshold: 0.01

    if !instance
      instance = this

    else
      instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () =>
    utils.log 'setup', 'setup()', 'image_preloader'

    # Setting Dimmer as Active
    $('[data-src] .ui.dimmer').dimmer('set dimmed', true)

    # pull in all of the images
    images = $('[data-src]')

    # store the count to be used later
    @image_count = images.length

    # check if the browser supports the observer
    if 'IntersectionObserver' of window
      @observer = new IntersectionObserver(@on_intersection, @config)

      # observe all images
      images.each (index,  image) =>
        @observer.observe image

    else
      $(images).each (index, image) =>
        @load_image image


    ## OLD

    # Setting Dimmer as Active
    # $('[data-src] .ui.dimmer').dimmer('set dimmed', true)

    # if @first_load
    #   window.onload = @load_images()

    #   # show the dimmer when switching off things
    #   # and unloads image before cache
    #   document.addEventListener 'turbolinks:before-cache', ->
    #     $('[data-src]').each (index,  value) ->
    #       item = $(value)
    #       item.css('background-image', '')
    #     $('[data-src] .ui.dimmer').dimmer('show')

    #   window.onload = null
    #   @first_load = false
    # else
    #   @load_images()



  teardown: () ->
    utils.log 'teardown', 'teardown()', 'image_preloader'

  disconnect: ->
    return unless @observer
    @observer.disconnect()

  on_intersection: (images) =>
    if @image_count == 0
      @disconnect()

    $(images).each (index, entry) =>
      if entry.intersectionRatio > 0
        @image_count--
        @load_image(entry.target)
        @observer.unobserve(entry.target)

  load_image: (image) =>

    target_image = $(image)
    image_src = target_image.data('src')

    if (typeof navigator.connection == 'undefined') || navigator.connection.downlink > 2.5
      container_height = Math.ceil(target_image.height()) * 2
    else
      container_height = Math.ceil(target_image.height())

    resize = image_src.match(/\/resize\/[^/]*\//g)

    # resize the resize if it exists or append it
    if resize
      image_src = image_src.replace(/\/resize\/[^/]*\//g, "/resize/x#{container_height}/")
    else
      image_src = image_src + "-/resize/x#{container_height}/"

    image_css_src = "url(#{image_src})"
    image_klass = target_image.data('klass')


    preloaded_image = new Image()
    preloaded_image.src = image_src

    image_loaded = =>
      target_image.css('background-image', image_css_src)
      target_image.addClass(image_klass)
      target_image.find('.dimmer').dimmer('hide')
      window.dimz =  target_image.find('.dimmer')


    preloaded_image.onload = image_loaded


  # load_images: () ->
  #   $('[data-src]').each (index,  value) ->

  #     if (typeof navigator.connection == 'undefined') || navigator.connection.downlink > 2.5
  #       container_height = Math.ceil($(@).height()) * 2
  #     else
  #       container_height = Math.ceil($(@).height())

  #     item = $(value)
  #     image_src = item.data('src')

  #     resize = image_src.match(/\/resize\/[^/]*\//g)

  #     # resize the resize if it exists or append it
  #     if resize
  #       image_src = image_src.replace(/\/resize\/[^/]*\//g, "/resize/x#{container_height}/")
  #     else
  #       image_src = image_src + "-/resize/x#{container_height}/"

  #     image_css_src = "url(#{image_src})"
  #     image_klass = item.data('klass')


  #     preloaded_image = new Image()
  #     preloaded_image.src = image_src

  #     image_loaded = =>
  #       item.css('background-image', image_css_src)
  #       item.addClass(image_klass)
  #       item.find('.dimmer').dimmer('hide')

  #     preloaded_image.onload = image_loaded

export { ImagePreloader as default }
