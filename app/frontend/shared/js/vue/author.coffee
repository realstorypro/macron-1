import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import axios from 'axios'
import store from './store/player_store'

# Components
import Profile from './components/profile'

class Author extends Common

  constructor: ->
      super('author')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      components:
        'profile': Profile
      computed:
        username: ->
          store.state.player.username

        level: ->
          store.state.player.level

        points: ->
          store.state.player.points

      mounted: ->
        store.dispatch('loadPlayer', @widget.userId)
        store.dispatch('subscribeToUpdaes', @widget.userId)

      data:
        widget: $("##{widget.id}").data()

export { Author as default }
