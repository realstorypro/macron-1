import Utils from '../core/utils'

utils =  new Utils

class Multiselect
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
    utils.log 'setup', 'setup()', 'multiselect'

    $('.ui.multiple.dropdown').each ->
      $that = $(this)
      values = $that.val()
      $('option', $that).each ->
        $(this).removeAttr 'selected'
      $that.dropdown 'set selected', values
      $('option', $that).each ->
        curr_value = $(this).val()
        i = 0
        while i < values
          if values[i] == curr_value
            $(this).attr 'selected', 'selected'
          i++


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'mutiselect'

export { Multiselect as default }
