import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import data_loader from './mixins/data_loader'
import axios from 'axios'


class Follower extends Common
  instance = null

  constructor: ->

    if !instance
      @register_events('follower')
      instance = this
    else
      instance


  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter, data_loader]
      mounted: ->
        console.log 'follower ::::', @passed
      methods:
        toggle: ->
          #console.log @, @passed, @passed.name, @passed.following

          console.log 'passed', @passed

          if @passed.following
            @passed.following = false
          else
            @passed.following = true

export { Follower as default }
