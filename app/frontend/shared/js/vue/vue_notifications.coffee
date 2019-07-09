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
        this.$notify({
          group: 'game',
          title: 'Important message',
          text: 'Hello user! This is a notification!'
        });
        this.$notify({
          group: 'game',
          title: 'Important message',
          text: 'Hello user! This is a notification!'
        });
        this.$notify({
          group: 'game',
          title: 'Important message',
          text: 'Hello user! This is a notification!'
        });


export { VueNotifications as default }
