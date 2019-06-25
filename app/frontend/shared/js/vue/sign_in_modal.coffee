import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'

import Utils from '../core/utils'
import Vent from '../core/vent'

utils = new Utils
vent = new Vent

class SignInModal extends Common
  constructor: ->
      super('sign_in_modal')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      data: ->
        widget: $("##{widget.id}").data()

      computed:
        modalWidth: ->
          if utils.is_mobile()
            "100%"
          else
            "480px"

        modalHeight: ->
          if utils.is_mobile()
            "400px"
          else
            "280px"

      methods:
        closeModal: ->
          @.$modal.hide('sign_in_modal')

        afterModalOpen: (e) ->
          vent.channel().trigger "navigation", "hide"

      mounted: ->
        console.log 'sign in modal mounted'

export { SignInModal as default }
