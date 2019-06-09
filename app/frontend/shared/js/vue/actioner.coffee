import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import axios from 'axios'
import store from './store/user_store'
import { VTooltip, VPopover, VClosePopover } from 'v-tooltip'

# Components
import Actions from './components/actions'
import Profile from './components/profile'
import ProgressBar from './components/progress_bar'
import AbilityButton from './components/ability_button'
import AbilityDetails from './components/ability_details'
import SelectAbility from './components/select_ability'

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
        'select-ability': SelectAbility
      directives:
        'tooltip': VTooltip
        'close-popover': VClosePopover
      methods:
        useAbility: (event) ->
          @current_access_key = event
        doCast: (percent) ->
          @castPercent = percent

          store.dispatch('castSpell',
            id: @widget.userId
            spell: @current_access_key,
            subject_id: @widget.subjectId,
            component: @widget.component
          ) if @castPercent == 100
      computed:
        username: ->
          store.state.user.username

        level: ->
          store.state.user.level

        points: ->
          store.state.user.points

        spells: ->
          store.state.user.spells

        entries: ->
          store.state.entry

        selectedAbility: ->
          return false unless @current_access_key
          store.state.user.spells.filter((item) =>
            item.access_key == @current_access_key
          )

      mounted: ->
        store.dispatch('loadUser', @widget.userId)
        store.dispatch('loadEntry', { id: @widget.subjectId, component: @widget.component } )

        cable.subscriptions.create { channel: 'EntryChannel', entry_id: @widget.subjectId},
          received: (_data) =>
            store.dispatch('loadEntry', { id: @widget.subjectId, component: @widget.component } )

      data:
        widget: $("##{widget.id}").data()
        current_access_key: null
        totalEnergy: 100
        currentEnergy: 80
        castPercent: 0
export { Actioner as default }
