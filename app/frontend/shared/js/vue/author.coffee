import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import axios from 'axios'
import store from './store/author_store'

# Components
import moment from 'moment'
import Avatar from 'vue-avatar'
import numeral from 'numeral'

class Author extends Common

  constructor: ->
      super('author')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      store: store
      components:
        'avatar': Avatar
      computed:
        username: ->
          store.state.player.username

        first_name: ->
          store.state.player.first_name

        last_name: ->
          store.state.player.last_name

        avatar: ->
          store.state.player.avatar
          
        job: ->
          store.state.player.job
          
        education: ->
          store.state.player.education

        supporters: ->
          store.state.player.supporters

        level: ->
          store.state.player.level

        points: ->
          store.state.player.points

        paths: ->
          store.state.player.paths

      methods:
        support: ->
          axios.post("/api/v1/players/#{@widget.userId}/support").then(
            (rsp) ->
              console.log 'successful', rsp
          ).catch(
            (err) ->
              console.log 'error', err
          )

        stop_supporting: ->
          axios.post("/api/v1/players/#{@widget.userId}/stop_supporting")

        toggle: ->
          @isLoading = true

          if @widget.supporting
            @stop_supporting()
          else
            @support()

          @widget.supporting = !@widget.supporting

      mounted: ->
        store.dispatch('loadPlayer', @widget.userId)

        cable.subscriptions.create { channel: 'PlayerChannel', user_id: @widget.userId},
          received: (_data) =>
            store.dispatch('loadPlayer', @widget.userId)
            @isLoading =  false

      data:
        widget: $("##{widget.id}").data()
        isLoading: false

export { Author as default }
