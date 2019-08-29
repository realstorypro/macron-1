import Utils from '../core/utils'
import Vent from '../core/vent'

utils =  new Utils
vent = new Vent

class Navigation
  instance = null

  constructor: ->
    @pre_cache_cleanup()
    @register_events()

    if !instance
      instance = this

    else
      instance

  reinit: () ->
    @teardown()
    @setup()

  register_events: () ->
    vent.channel().on "navigation", (action) =>

      switch action
        when 'hide' then @hideNavbar()


  setup: () ->
    utils.log 'setup', 'setup()', 'navigation'

    # setting up initial variables
    did_scroll = false
    last_scroll_position = 0
    navbar = $('.navigation.widget')
    navbar_height = navbar.outerHeight()

    if ($('.page.home')).length > 0
      homepage= true
    else
      homepage = false

    if ($('.article.details')).length > 0
      inverted_header = true
    else
      inverted_header = false

    # on scroll, let the interval function know the user has scrolled
    $(window).scroll =>
      did_scroll = true

    # run has_scrolled() and reset did_Scroll status
    setInterval (=>
      if did_scroll
        has_scrolled()
        did_scroll = false
    ), 4

    has_scrolled = ->
      scroll_position = $(window).scrollTop()

      # scrolling down
      if scroll_position > last_scroll_position
        
        # showing navbar on re-apperance
        navbar.css('opacity', '1')

        if homepage
          if scroll_position > ( navbar_height * 0.7)
            navbar.css('top', "-#{navbar_height+15}px")
          if scroll_position > 0
            navbar.addClass('mini')
        else if inverted_header
          if scroll_position > 400
            navbar.css('top', "-#{navbar_height+15}px")
          if scroll_position > 0
            navbar.addClass('mini')
        else
          if scroll_position > ( navbar_height * 0.7)
            navbar.css('top', "-#{navbar_height+15}px")
          if scroll_position > 0
            navbar.addClass('mini')


      # scrolling up
      else

        # change the css from fixed to relative if we are the top
        # this prevents the navbar from bouncing
        if scroll_position < 0
          #navbar.css('position', 'relative')
          #console 'its less then zero bro'
          #navbar.css('top', scroll_position * -1)
          navbar.css('transition', '0.4s')
          navbar.css('opacity', '0')
        else
          navbar.css('top', 0)

          if inverted_header
            unless scroll_position > 50
              navbar.removeClass('mini')
          else
            unless scroll_position > 0
              navbar.removeClass('mini')

      last_scroll_position = scroll_position


  hideNavbar: () ->
    navbar = $('.navigation.widget')
    navbar_height = navbar.outerHeight()
    navbar.css('top', "-#{navbar_height+15}px")

  teardown: () ->
    utils.log 'teardown', 'teardown()', 'navigation'

    $(window).off('scroll')

  # resets the navbar position to the top of the page
  pre_cache_cleanup: () ->
    document.addEventListener 'turbolinks:before-cache', ->
      navbar = $('.navigation.widget')
      navbar.css('top', 0)
      navbar.removeClass('mini')

export { Navigation as default }
