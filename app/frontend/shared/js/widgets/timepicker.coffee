import Utils from '../core/utils'
import 'pickadate-webpack/lib/picker'
import 'pickadate-webpack/lib/picker.time'

utils =  new Utils

class Timepicker
  instance = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'datepicker'

    $('input.timepicker').pickatime()


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'datepicker'

export { Timepicker as default }
