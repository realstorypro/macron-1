import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import axios from 'axios'

class Liker extends Common

  constructor: ->
      super('liker')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      data:
        widget: $("##{widget.id}").data()
      methods:
        add_like: ->
          params =
            component: @widget.component
            record_id: @widget.recordId

          axios.post("/api/v1/likes/#{@widget.userId}/add", params).then(
            (rsp) ->
              console.log 'successful', rsp
          ).catch(
            (err) ->
              console.log 'error', err
          )

        remove_like: ->
          params =
            component: @widget.component
            record_id: @widget.recordId
          axios.post("/api/v1/likes/#{@widget.userId}/remove", params ).then(
            (rsp) ->
              console.log 'successful', rsp
          ).catch(
            (err) ->
              console.log 'error', err
          )

        toggle: ->
          if @widget.liked
            @widget.likes -= 1
            @remove_like()
          else
            @widget.likes += 1
            @add_like()

          @widget.liked = !@widget.liked


export { Liker as default }
