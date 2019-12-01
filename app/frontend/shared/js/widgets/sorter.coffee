import Utils from '../core/utils'
import Sortable from 'sortablejs'
import axios from 'axios'
import Vent from '../core/vent'

vent = new Vent

utils = new Utils

class Sorter
  sortable = []
  instance = null

  constructor: ->

    if !instance
      instance = this

      vent.channel().on "widget:sorter", (options) =>
        switch options['action']
          when 'toggle' then @toggle(options)


    else
      instance

  reinit: ->
    @teardown()
    @setup()
    @toggle() if $('.page.builder').hasClass('active')

  setup: ->
    utils.log 'setup', 'setup()', 'sorter'

    $('.sortable').each (i, element) =>
      widget = $(element)
      target = widget.data('target')

      if widget.length > 0
        sortable_item = Sortable.create widget[0],
          disabled: true
          onSort: ->
            axios.post target, { order: @.toArray() }

        sortable.push sortable_item

  toggle: (options) ->
    $(sortable).each ->
      state = @.option("disabled")
      @.option("disabled", !state)

  teardown: ->
    utils.log 'teardown', 'teardown()', 'sorter'

    $(sortable).each ->
      @.destroy()

    sortable = []


export { Sorter as default }

