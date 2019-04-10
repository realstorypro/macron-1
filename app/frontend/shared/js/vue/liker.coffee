import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'


class Liker extends Common

  constructor: ->
      super('liker')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      data:
        widget: $("##{widget.id}").data()

export { Liker as default }
