import Utils from '../core/utils'

utils =  new Utils

class Checkbox
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
    utils.log 'setup', 'setup()', 'checkbox'

    $('.ui.checkbox').checkbox()

  teardown: () ->
    utils.log 'teardown', 'teardown()', 'checkbox'

export { Checkbox as default }

