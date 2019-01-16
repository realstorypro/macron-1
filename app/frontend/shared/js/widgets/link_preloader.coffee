import Utils from '../core/utils'

utils =  new Utils

class LinkPreloader
  instance = null

  constructor: ->

    @link_history = []

    # setting an observer up
    @observer = null
    @observer_config =
      rootMargin: '50px 0px'
      threshold: 0.01


    # number of links we're observing
    @link_count = 0

    if !instance
      instance = this

    else
      instance

  reinit: () ->
    @teardown()
    @setup()


  setup: () =>
    utils.log 'setup', 'setup()', 'link_preloader'

    # pull in all of the images
    preloadable_links = $('[data-preloadable]')

    # store the count to be used later
    @link_count = preloadable_links.length

    # check if the browser supports the observer
    if 'IntersectionObserver' of window
      @observer = new IntersectionObserver(@on_intersection, @observer_config)

      # observe all preloadble links
      preloadable_links.each (index,  link) =>
        @observer.observe link


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'link_preloader'
    @disconnect()

  disconnect: ->
    return unless @observer
    @observer.disconnect()

  on_intersection: (images) =>
    if @link_count == 0
      @disconnect()

    $(images).each (index, entry) =>
      if entry.intersectionRatio > 0
        @link_count--
        @load_link(entry.target)
        @observer.unobserve(entry.target)

  load_link: (link) =>
    if @link_history.indexOf(link.href) == -1
      @link_history.push(link.href)
      $.get link.href

export { LinkPreloader as default }
