import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import data_loader from './mixins/data_loader'


class Liker extends Common

  constructor: ->
    super('liker')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter, data_loader]

export { Liker as default }
