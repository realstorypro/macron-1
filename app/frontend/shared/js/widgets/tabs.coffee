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
    utils.log 'setup', 'setup()', 'tabs'

    console.log $('.ui.tabular.menu .item')
    $('.ui.tabular.menu .item').tab()

  teardown: () ->
    utils.log 'teardown', 'teardown()', 'tabs'

export { Dropdown as default }
