import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import axios from 'axios'
import Actions from './components/actions'
import { VTooltip, VPopover, VClosePopover } from 'v-tooltip'

class Actioner extends Common

  constructor: ->
      super('actioner')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      components:
        'actions' : Actions
        'v-popover': VPopover
      directives:
        'tooltip': VTooltip
        'close-popover': VClosePopover
      data:
        widget: $("##{widget.id}").data()

export { Actioner as default }
