import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import axios from 'axios'


class Follower extends Common
  instance = null

  constructor: ->
    super('follower')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      data:
        widget: $("##{widget.id}").data()
      methods:
        add_follower: ->
          axios.post("/api/v1/followers/#{@widget.userId}/add").then(
            (rsp) ->
              console.log 'successful', rsp
          ).catch(
            (err) ->
              console.log 'error', err
          )

        remove_follower: ->
          axios.post("/api/v1/followers/#{@widget.userId}/remove")

        toggle: ->
          if @widget.following
            @remove_follower()
          else
            @add_follower()

          @widget.following = !@widget.following

export { Follower as default }
