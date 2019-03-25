import Utils from './utils'
import Vent from './vent'
import Dispatcher from './dispatcher'
import Dropdown from '../widgets/dropdown'
import Datepicker from '../widgets/datepicker'
import Timepicker from '../widgets/timepicker'
import Richtext from '../widgets/richtext'
import Sorter from '../widgets/sorter'
import Multiselect from '../widgets/multiselect'
import _ from 'underscore'

utils =  new Utils
vent =  new Vent
dispatcher = new Dispatcher
dropdown = new Dropdown
datepicker = new Datepicker
timepicker = new Timepicker
sorter = new Sorter
multiselect = new Multiselect
richtext = new Richtext

class Render

  instance = null

  # implementing singleton pattern
  constructor : () ->
    if !instance
      instance = this

      vent.channel().on "render", (options) =>
        switch options['action']
          when 'update' then @update(options)
          when 'refresh' then @refresh(options)

    instance

    # updates target element
  update: (options) ->
    utils.log 'status', 'render.update()', 'render'

    defaults =
      element: ""
      html: ""

    _.defaults(options, defaults)

    try
      template = _.template(options.html)
      partial = $(template()).find("#{options.element}").html()

      # if we're not replacing partial dump the whole template into the html
      if partial?
        html = partial
      else
        html = template()

      $("#{options.element}").html(html)

      dropdown.reinit()
      datepicker.reinit()
      timepicker.reinit()
      multiselect.reinit()
      richtext.reinit()
      sorter.reinit()
      dispatcher.reinit()

    catch error
      utils.log 'error', "render.update(): #{error}", 'render'

# refresh the pages elements based on unique ids
  refresh: (options) ->
    utils.log 'status', 'render.refresh()', 'render'

    defaults =
      html: "not set"

    _.defaults(options, defaults)
    template = _.template(options.html)

    try
      $(template()).find(".dynamic").each (index, el) ->
        id = $(el).attr('id')
        html = $(el).html()

        $("##{id}").html(html)

      dropdown.reinit()
      datepicker.reinit()
      timepicker.reinit()
      multiselect.reinit()
      richtext.reinit()
      sorter.reinit()
      dispatcher.reinit()

    catch error
      utils.log 'error', 'render.refresh()', 'render'

export { Render as default }
