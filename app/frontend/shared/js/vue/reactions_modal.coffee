import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'

import Utils from '../core/utils'
import Vent from '../core/vent'

utils = new Utils
vent = new Vent

import axios from 'axios'
import store from '../vue/store/user_store'

import Score from '../vue/components/reactions/score'
import ProgressBar from '../vue/components/reactions/progress_bar'
import AbilityButton from '../vue/components/reactions/ability_button'
import AbilityDetails from '../vue/components/reactions/ability_details'
import SelectAbility from '../vue/components/reactions/select_ability'


class ReactionsModal extends Common
  constructor: ->
      super('reactions_modal')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      components:
        'score': Score
        'progress-bar': ProgressBar
        'ability-button': AbilityButton
        'ability-details': AbilityDetails
        'select-ability': SelectAbility
      data: ->
        widget: $("##{widget.id}").data()
        current_access_key: null

        casting: false
        currentCastTime: 0
        castInterval: 70

      computed:
        scores: ->
          store.state.entry
        level: ->
          store.state.user.level
        spells: ->
          store.state.user.spells
        energy: ->
          store.state.user.energy
        energyPercent: ->
          store.state.user.energy / store.state.user.max_energy * 100
        selectedAbility: ->
          return false unless @current_access_key
          store.state.user.spells.filter((item) =>
            item.access_key == @current_access_key
          )

        modalWidth: ->
          if utils.is_mobile()
            "100%"
          else
            "500px"

        modalHeight: ->
          if utils.is_mobile()
            "385px"
          else
            "380px"

        modalPivotY: ->
          if utils.is_mobile()
            1
          else
            0.5

        completedPercent: ->
          current_ability = @currentAbility()
          Math.floor(@currentCastTime/current_ability.castTime*100)

        actionClass: ->
          current_ability = @currentAbility()
          ability_direction = current_ability.direction

          ability_class = 'green' if ability_direction == 'positive'
          ability_class = 'red' if ability_direction == 'negative'

          return 'grey disabled' if (store.state.user.energy == 0) || (current_ability && current_ability.energy > store.state.user.energy)
          return 'grey disabled' if @current_access_key == null
          return "#{ability_class} casting" if @casting 
          return ability_class unless @casting


        actionText: ->
          current_ability = @currentAbility()

          return 'NEED ENERGY' if (store.state.user.energy == 0) || (current_ability && current_ability.energy > store.state.user.energy)
          return 'CANCEL' if @casting
          return 'CAST' unless @casting

      methods:
        useAbility: (event) ->
          @current_access_key = event

        currentAbility: ->
          return false unless @current_access_key
          store.state.user.spells.filter((item) =>
            item.access_key == @current_access_key
          )[0]


        cast: ->
          @currentCastTime = 0

          unless @casting
            @interval = setInterval(@castCounter,@castInterval)
          else
            clearInterval(@interval)

          @casting = !@casting


        castCounter: ->
          current_ability = @currentAbility()
          if (@currentCastTime + @castInterval >= current_ability.castTime) || (@completed_percent == 100)
            clearInterval(@interval)
            @doCast()
          else
            @currentCastTime += @castInterval

        doCast: ->
          cast_response = store.dispatch('castSpell',
            id: @widget.userId
            spell: @current_access_key,
            subject_id: @widget.subjectId,
            component: @widget.component
          )

          current_spells = store.state.user.spells.filter((item) =>
            item.access_key == @current_access_key
          )

          spell_name = current_spells[0].name
          spell_direction = current_spells[0].direction

          notification_type = 'success' if spell_direction == 'positive'
          notification_type = 'error' if spell_direction == 'negative'

          cast_response.then (rsp) =>
            cast_points = rsp.data.points
            unless cast_points is false
              @.$notify
                group: 'game'
                type: notification_type
                title: "#{spell_name} was cast for #{cast_points} points."
            else
              @.$notify
                group: 'game'
                type: 'error'
                title: "#{spell_name} was not cast. Please try again later."


          ability = store.state.user.spells.filter((item) =>
            item.access_key == @current_access_key
          )
          store.dispatch('reduceEnergy', ability[0].energy)

          @closeModal()


        # Modal Methods
        closeModal: ->
          # Resetting variables to defaults
          @current_access_key = null
          @currentCastTime = 0
          @casting = false

          # Closing the actual modal
          @.$modal.hide('reaction-modal')

        afterModalOpen: (e) ->
          vent.channel().trigger "navigation", "hide"

      mounted: ->
        store.dispatch('loadUser', @widget.userId)
        store.dispatch('loadEntry', { id: @widget.subjectId, component: @widget.component } )

        cable.subscriptions.create { channel: 'UserChannel', user_id: @widget.userId},
          received: (_data) =>
            store.dispatch('loadUser', @widget.userId)

export { ReactionsModal as default }
