import Utils from '../core/utils'

utils =  new Utils

class Dropdown
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
    utils.log 'setup', 'setup()', 'dropdown'

    $('.ui.dropdown').not('.multiple').not('.widgeted').dropdown()


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'dropdown'

export { Dropdown as default }
