import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import axios from 'axios'
import store from './store/author_store'

# Components
import moment from 'moment'
import Avatar from 'vue-avatar'
import numeral from 'numeral'
import AnimatedNumber from "animated-number-vue"

class Author extends Common

  constructor: ->
      super('author')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      store: store
      components:
        'avatar': Avatar
        'animated-number': AnimatedNumber
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

        activePaths: ->
          @paths.filter (p) ->
            p.level > 1


      methods:
        formatToInt: (value) ->
          if value > 1000
            "#{Number(value/1000).toFixed(1)}k Reputation"
          else
            "#{Number(value).toFixed(0)} Reputation"
        support: ->
          axios.post("/api/v1/users/#{@widget.userId}/support").then(
            (rsp) ->
          ).catch(
            (err) ->
          )

        stop_supporting: ->
          axios.post("/api/v1/users/#{@widget.userId}/stop_supporting")

        toggle: ->
          @isLoading = true

          if @widget.supporting
            @stop_supporting()
          else
            @support()

          @widget.supporting = !@widget.supporting

        signInModal: ->
          @.$modal.show('sign-in-modal')

      mounted: ->
        store.dispatch('loadUser', @widget.userId)

        cable.subscriptions.create { channel: 'UserChannel', user_id: @widget.userId},
          received: (_data) =>
            store.dispatch('loadUser', @widget.userId)
            @isLoading =  false

      data:
        widget: $("##{widget.id}").data()
        isLoading: false

export { Author as default }
