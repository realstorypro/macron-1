import Utils from '../core/utils'
import Sortable from 'sortablejs'
import axios from 'axios'

utils = new Utils

class Sorter
  instance = null

  token = document.getElementsByName('csrf-token')[0].content
  axios.defaults.headers.common['X-CSRF-Token'] = token
  axios.defaults.headers.common['Accept'] = 'application/json'

  constructor: ->
    @sortable = []

    if !instance
      instance = this

    else
      instance

  reinit: ->
    @teardown()
    @setup()

  setup: ->
    utils.log 'setup', 'setup()', 'sorter'

    $('.sortable').each ->
      widget = $(@)
      target = widget.data('target')

      if widget.length > 0
        @sortable << Sortable.create widget[0],
          onSort: ->
            axios.post target, { order: @.toArray() }

  teardown: ->
    utils.log 'teardown', 'teardown()', 'sorter'

    $(@sortable).each ->
      @.destroy()

    @sortable = []


export { Sorter as default }

