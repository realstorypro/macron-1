import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'

import Utils from '../core/utils'
import Vent from '../core/vent'

utils = new Utils
vent = new Vent

class VueNotifications extends Common
  constructor: ->
      super('vue_notifications')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      data: ->
        widget: $("##{widget.id}").data()
      mounted: ->
          title = Object.keys(window.notifications)[0]
          notification = window.notifications[Object.keys(window.notifications)[0]]
          if notification
            this.$notify({
              group: 'game',
              title: title.toUpperCase(),
              text: notification
            });


export { VueNotifications as default }
