import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'

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
      mixins: [turbolinks_adapter]
      components:
        'score': Score
        'progress-bar': ProgressBar
        'ability-button': AbilityButton
        'ability-details': AbilityDetails
        'select-ability': SelectAbility
      data: ->
        widget: $("##{widget.id}").data()
        current_access_key: null
        castPercent: 0
        activeCast: false

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
            "400px"
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


      methods:
        useAbility: (event) ->
          @current_access_key = event




        # REFACTOR BEGINS

        currentAbility: ->
          return false unless @current_access_key
          store.state.user.spells.filter((item) =>
            item.access_key == @current_access_key
          )[0]


        cast: ->
          @currentCastTime = 0

          unless @casting
            console.log 'start casting'
            @interval = setInterval(@castCounter,@castInterval)
          else
            console.log 'stop casting'
            clearInterval(@interval)

          @casting = !@casting


        castCounter: ->
          current_ability = @currentAbility()
          if (@currentCastTime + @castInterval >= current_ability.castTime) || (@completed_percent == 100)
            clearInterval(@interval)
            @casting = false
            @doCast(100)
          else
            @currentCastTime += @castInterval




        ## REFACTOR ENDS ###

        doCast: (percent) ->
          @castPercent = percent

          if @castPercent == 100
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

            cast_response.then (rsp) =>
              cast_points = rsp.data.points
              unless cast_points is false
                @.$notify
                  group: 'game'
                  title: 'Vote Cast'
                  text: "#{spell_name} was cast for #{cast_points} points."
              else
                @.$notify
                  group: 'game'
                  title: 'Error Casting a Vote'
                  text: "#{spell_name} was not cast. Please try again later."


            ability = store.state.user.spells.filter((item) =>
              item.access_key == @current_access_key
            )
            store.dispatch('reduceEnergy', ability[0].energy)
            @closeModal()


        # Modal Methods
        closeModal: ->
          @current_access_key = null
          @activeCast = false
          @castPercent = 0
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
