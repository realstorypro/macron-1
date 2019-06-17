import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'

# REMOVE SOON #
import axios from 'axios'
import store from './store/user_store'
import { VTooltip, VPopover, VClosePopover } from 'v-tooltip'
# REMOVE SOON #

# Refactor Begins
import VModal from 'vue-js-modal'
import Reactions from './components/reactions'

Vue.use(VModal)

# Components
import Actions from './components/actions'
import Profile from './components/profile'
# import ProgressBar from './components/progress_bar'
# import AbilityButton from './components/ability_button'
# import AbilityDetails from './components/ability_details'
# import SelectAbility from './components/select_ability'
import AnimatedNumber from "animated-number-vue"

class Actioner extends Common

  constructor: ->
      super('actioner')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      components:
        'reactions' : Reactions
        'actions' : Actions
        'v-popover': VPopover
        'profile': Profile
        'animated-number': AnimatedNumber
      directives:
        'tooltip': VTooltip
        'close-popover': VClosePopover
      methods:
        formatToInt: (value) ->
          return Number(value).toFixed(0)
        useAbility: (event) ->
          @current_access_key = event
        doCast: (percent) ->
          @castPercent = percent

          if @castPercent == 100
            store.dispatch('castSpell',
              id: @widget.userId
              spell: @current_access_key,
              subject_id: @widget.subjectId,
              component: @widget.component
            )

            ability = store.state.user.spells.filter((item) =>
              item.access_key == @current_access_key
            )
            store.dispatch('reduceEnergy', ability[0].energy)

            @activeCast = true
      computed:
        username: ->
          store.state.user.username

        level: ->
          store.state.user.level

        points: ->
          store.state.user.points

        spells: ->
          store.state.user.spells

        energy: ->
          store.state.user.energy

        energyPercent: ->
          store.state.user.energy / store.state.user.max_energy * 100

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

        cable.subscriptions.create { channel: 'UserChannel', user_id: @widget.userId},
          received: (_data) =>
            store.dispatch('loadUser', @widget.userId)
            @activeCast = false

      data:
        widget: $("##{widget.id}").data()
        current_access_key: null
        castPercent: 0
        activeCast: false
export { Actioner as default }
