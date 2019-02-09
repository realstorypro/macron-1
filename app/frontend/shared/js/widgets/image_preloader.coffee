import Utils from '../core/utils'

utils =  new Utils

class ImagePreloader
  instance = null

  constructor: ->
    @pre_cache_cleanup()

    # setting an observer up
    @observer = null
    @observer_config =
      rootMargin: '50px 0px'
      threshold: 0.01


    # number of images we're observing
    @image_count = 0

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
      @observer = new IntersectionObserver(@on_intersection, @observer_config)

      # observe all images
      images.each (index,  image) =>
        @observer.observe image

    else
      $(images).each (index, image) =>
        @load_image image


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'image_preloader'
    @disconnect()

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
    image_alt = target_image.data('alt')

    if (typeof navigator.connection == 'undefined') || navigator.connection.downlink > 2.5
      container_height = Math.ceil(target_image.height()) * 2
      container_width = Math.ceil(target_image.width()) * 2
    else
      container_height = Math.ceil(target_image.height())
      container_width = Math.ceil(target_image.width())

    resize = image_src.match(/\/resize\/[^/]*\//g)

    # resize the resize if it exists or append it
    if resize
      image_src = image_src.replace(/\/resize\/[^/]*\//g, "/resize/#{container_width}x#{container_height}/")
    else
      image_src = image_src + "-/resize/#{container_width}x#{container_height}/"

    # add the jpeg extension for seo benefits if alt is defined
    if image_alt?
      image_src = image_src + image_alt + '.jpg'

    image_klass = target_image.data('klass')

    preloaded_image = new Image()
    preloaded_image.src = image_src

    image_loaded = =>
      target_image.find('img').attr('src', image_src)
      target_image.addClass(image_klass)
      target_image.find('.dimmer').dimmer('hide')

    preloaded_image.onload = image_loaded

  # show the dimmer when switching off things and unloads image
  pre_cache_cleanup: () ->
    document.addEventListener 'turbolinks:before-cache', ->
      $('[data-src]').each (index,  value) ->
        item = $(value)
        item.css('background-image', '')
      $('[data-src] .ui.dimmer').dimmer('show')

export { ImagePreloader as default }
