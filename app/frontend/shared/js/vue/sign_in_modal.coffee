import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'

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
      data: ->
        widget: $("##{widget.id}").data()

      computed:
        modalWidth: ->
          if utils.is_mobile()
            "90%"
          else
            "480px"

        modalHeight: ->
          if utils.is_mobile()
            "280px"
          else
            "280px"

      methods:
        closeModal: ->
          @.$modal.hide('sign_in_modal')

        afterModalOpen: (e) ->
          vent.channel().trigger "navigation", "hide"

export { SignInModal as default }
