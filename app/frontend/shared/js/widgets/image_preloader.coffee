import Utils from '../core/utils'

utils =  new Utils

class ImagePreloader
  instance = null

  constructor: ->
    if !instance then instance = this
    return instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'image_preloader'

    # Setting Dimmer as Active
    $('[data-src] .ui.dimmer').dimmer('set dimmed', true)

    $('[data-src]').each (index,  value) ->

      item = $(value)
      image_src = item.data('src')
      image_css_src = "url(#{image_src})"

      preloaded_image = new Image()
      preloaded_image.src = image_src

      image_loaded = =>
        item.css('background-image', image_css_src)
        item.find('.dimmer').dimmer('hide')

      preloaded_image.onload = image_loaded

    # Unload Images Before Cache
    document.addEventListener 'turbolinks:before-cache', ->
      $('[data-src]').each (index,  value) ->
        item = $(value)
        item.css('background-image', '')

      $('[data-src] .ui.dimmer').dimmer('show')


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'image_preloader'


export { ImagePreloader as default }
