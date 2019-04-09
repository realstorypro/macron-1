import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import data_loader from './mixins/data_loader'


class Liker extends Common
  instance = null

  constructor: ->
    if !instance
      @register_events('liker')
      instance = this
    else
      instance

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter, data_loader]
      mounted: ->
        console.log 'liker ::::', @passed

export { Liker as default }
