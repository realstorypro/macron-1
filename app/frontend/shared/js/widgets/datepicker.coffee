import Utils from '../core/utils'
import 'pickadate-webpack/lib/picker'
import 'pickadate-webpack/lib/picker.date'

utils =  new Utils

class Datepicker
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

    $('input.datepicker').pickadate
      format: 'mmmm dd, yyyy'


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'datepicker'

export { Datepicker as default }
