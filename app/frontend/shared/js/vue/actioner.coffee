import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import axios from 'axios'
import Actions from './components/actions'
import Profile from './components/profile'
import ProgressBar from './components/progress_bar'
import AbilityButton from './components/ability_button'
import AbilityDetails from './components/ability_details'
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
        'profile': Profile
        'progress-bar': ProgressBar
        'ability-button': AbilityButton
        'ability-details': AbilityDetails
      directives:
        'tooltip': VTooltip
        'close-popover': VClosePopover
      methods:
        useAbility: (event) ->
          @current_access_key = event
      computed:
        selectedAbility: ->
          return false unless @current_access_key
          @abilities.filter((item) =>
            item.access_key == @current_access_key
          )

      data:
        widget: $("##{widget.id}").data()
        current_access_key: null

        abilities:[
          {
            name: 'Aho'
            disabled: false
            access_key: 'applause'
            icon: 'hand rock'
            color: 'green'
            description: 'A sign of agreement used by the Native American tribes.'
            points:
              low: 60
              high: 100
            direction: 'positive'
          },
          {
            name: 'Haux Haux'
            disabled: false
            access_key: 'haux'
            icon: 'shield alternate'
            color: 'green'
            description: 'A spell of protection cast by the Shamans of the amazon.'
            points:
              low: 120
              high: 500
            direction: 'positive'
          },
          {
            name: 'Silence'
            disabled: false
            access_key: 'silence'
            icon: 'microphone slash'
            color: 'red'
            description: 'An offensive debuff designed to silence the speaker. First used by the grand inquisitor of the Catholic church.'
            points:
              low: 500
              high: 1020
            direction: 'negative'
          }
        ]

export { Actioner as default }
