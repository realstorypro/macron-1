import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'

import store from './store/actioner_store'
import Score from './components/reactions/score'

class Actioner extends Common

  constructor: ->
      super('actioner')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      components:
        'score' : Score
      computed:
        scores: ->
          store.state.entry
      mounted: ->
        store.dispatch('loadEntry', { id: @widget.subjectId, component: @widget.component } )
      methods:
        showMobileModal: ->
          @.$modal.show('reaction-modal')
        signInModal: ->
          @.$modal.show('sign-in-modal')
      data:
        widget: $("##{widget.id}").data()

export { Actioner as default }
