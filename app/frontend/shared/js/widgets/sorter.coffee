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
    @sortable = null

    if !instance
      instance = this

    else
      instance

  reinit: ->
    @teardown()
    @setup()

  setup: ->
    utils.log 'setup', 'setup()', 'sorter'

    widget = $('.sortable')
    target = widget.data('target')

    @sortable = Sortable.create widget[0],
      onSort: ->
        axios.post target, { order: @.toArray() }

  teardown: ->
    utils.log 'teardown', 'teardown()', 'sorter'

    unless @sortable == null
      @sortable.destroy()
      @sortable = null


export { Sorter as default }

