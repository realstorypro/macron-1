import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import axios from 'axios'
import Cable from '../../core/cable'


Vue.use(Vuex)

store = new (Vuex.Store)(
  state:
    player:
      username: 'guest'
      level: 0
      spells: {}

  mutations:
    load: (state, player) ->
      state.player = player

  actions:
    loadPlayer: ({commit}, user_id) ->
      console.log user_id
      axios.get("/api/v1/player/#{user_id}").then (response) =>
        console.log response.data
        commit('load', response.data)

    castSpell: ({commit}, options) ->
      axios.post("/api/v1/player/cast", options).then (response) =>
        console.log response.data

    subscribeToUpdaes: ({commit}, user_id) ->
      cable = (new Cable)
      console.log "cable", cable
      cable.subscriptions.create { channel: 'ActivityChannel', user_id: user_id },
        received: (data) ->
          commit('add_new_activity', data.activity_id)
)

export {store as default}
