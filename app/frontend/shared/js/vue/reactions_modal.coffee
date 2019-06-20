import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'

# Refactor Out
import Utils from '../core/utils'

import axios from 'axios'
import store from '../vue/store/user_store'

import Score from '../vue/components/reactions/score'
import ProgressBar from '../vue/components/reactions/progress_bar'
import AbilityButton from '../vue/components/reactions/ability_button'
import AbilityDetails from '../vue/components/reactions/ability_details'
import SelectAbility from '../vue/components/reactions/select_ability'
import Redactor from '../vue/components/redactor'

utils = new Utils


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
        'redactor': Redactor
      data: ->
        widget: $("##{widget.id}").data()
        current_access_key: null
        castPercent: 0
        activeCast: false
        comment: ''
        redactorConfig:
          minHeight: '100%'
          maxHeight: '100%'

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
            "650px"

        modalHeight: ->
          if utils.is_mobile()
            "100%"
          else
            "700px"

      methods:
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
        closeModal: ->
          @.$modal.hide('reaction-modal')

        sizeCommentsBox: (e) ->
          wrap_height =  $(@.$el).find('.v--modal').outerHeight(true)
          bars_height =  $(@.$el).find('.bars').outerHeight(true)
          abilities_height =  $(@.$el).find('.abilities').outerHeight(true)
          details_height =  $(@.$el).find('.details').outerHeight(true)

          if utils.is_mobile()
            adjustment = 150
          else
            adjustment = 140

          # 54 is the size of the readactor toolbar
          comment_height = wrap_height - bars_height - abilities_height - details_height - 54 - adjustment

          $(@.$el).find('.redactor-in').css('min-height', "#{comment_height}px")
          $(@.$el).find('.redactor-in').css('max-height', "#{comment_height}px")

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

export { ReactionsModal as default }
