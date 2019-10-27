import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'

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
      data: ->
        widget: $("##{widget.id}").data()
      computed: 
        notification_position: ->
          if utils.is_mobile()
            "bottom center"
          else
            "bottom right"

      mounted: ->
          title = Object.keys(window.notifications)[0]
          notification = window.notifications[Object.keys(window.notifications)[0]]
          if notification
            @.$notify
              group: 'game'
              title: title.toUpperCase()
              type: title.toLowerCase()
              text: notification


export { VueNotifications as default }
