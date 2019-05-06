import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import axios from 'axios'
import Cable from '../../core/cable'

cable = (new Cable).cable

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
    loadPlayer: ({commit}) ->
      axios.get("/api/v1/player/").then (response) =>
        console.log response.data
        commit('load', response.data)

    castSpell: ({commit}, options) ->
      axios.post("/api/v1/player/cast", options).then (response) =>
        console.log response.data
)

export {store as default}
