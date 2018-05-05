import _ from 'underscore'
import Settings from './settings'

settings = new Settings

class Utils
  instance = null

  line_length = 80

  # implementing singleton pattern
  constructor : () ->
    if !instance then instance = this
    return instance

  ##################################################
  ### Print Functions ###
  ##################################################

  log: (type, message, location=null) ->
    if type == 'attach'
      message = "attaching to #{message}"
    if type == 'dettach'
      message = "detaching from #{message}"

    unless !location?
      message = "#{location}: #{message}"

    if settings.on 'debug'
      switch type
        when 'setup'
          @print_to_text(message, 'white', '#287047', 'bold', ' >>> ')
        when 'teardown'
          @print_to_text(message, 'white', '#C94052', 'bold', ' <<< ')
        when 'status'
          @print_to_text(message, '#2589BD', 'white', '', '', 'center')
        when 'trigger'
          @print_to_text(message, '#2589BD', 'white', '', ' * ')
        when 'setting'
          @print_to_text(message, '#2589BD', '#F8F8F8', 'bold', '[-] ')
        when 'header'
          @print_to_text(message, '#890A0A', '#F2D0A4', 'bold', '', 'center')
        when 'error'
          @print_to_text(message, 'red', 'white', 'bold', '', 'center')

  print_to_text: (message, background_color, font_color, font_weight, prefix, position = 'left') ->
    if position == 'center'
      padding = Math.ceil((line_length - message.length)/2)
      spacer = Array(padding+1).join' '
      message = "#{spacer}#{message}#{spacer}"
      console.log "%c#{message}", "background: #{background_color}; color: #{font_color}; font-weight: #{font_weight}"

    else
      padding = (line_length - message.length - prefix.length)
      spacer = Array(padding+1).join' '
      message = "#{message}#{spacer}"
      console.log "%c#{prefix}#{message}", "background: #{background_color}; color: #{font_color}; font-weight: #{font_weight}"


  ##################################################
  ### Drawing Functions ###
  ##################################################

  draw: (type, background_color, font_color) ->
    if settings.on 'debug'
      switch type
        when 'line'
          @draw_to_text('-', background_color, font_color)
        when 'stars'
          @draw_to_text('*', background_color, font_color)
        when 'blank'
          @draw_to_text(' ', background_color, font_color)
        when 'blank_header'
          @draw_to_text(' ', 'black', 'white')
        when 'status_header'
          @draw_to_text(' ', '#2589BD', 'white')

  draw_to_text: (symbol, background_color, font_color, font_weight = 'normal') ->
    lines = Array(line_length+1).join(symbol)
    console.log "%c#{lines}", "background: #{background_color}; color: #{font_color}; font-weight: #{font_weight}"


  ##################################################
  ### Mobile Tools ###
  ##################################################
  is_mobile: ->
    isMobile = window.matchMedia('only screen and (max-width: 760px)')

    if isMobile.matches
      true
    else
      false


export { Utils as default}
