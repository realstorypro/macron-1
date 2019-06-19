import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'

import Modal from './components/reactions/modal'

class ReactionsModal extends Common
  constructor: ->
      super('reactions_modal')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      components:
        'modal': Modal
      mounted: ->
        console.log "reacitons modal mounted"

export { ReactionsModal as default }
