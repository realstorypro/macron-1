import Utils from '../core/utils'

utils =  new Utils

class Sticky
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
    utils.log 'setup', 'setup()', 'sticky'

    $('.ui.dropdown').not('.multiple').not('.widgeted').dropdown()
    $('.sticky .stuck') .sticky({ context: '.sticky .context' })


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'sticky'

export { Sticky as default }
