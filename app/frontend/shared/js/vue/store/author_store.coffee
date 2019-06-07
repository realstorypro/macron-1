import Vuex from 'vuex'
import axios from 'axios'


store = new (Vuex.Store)(
  state:
    player:
      username: 'guest'
      job: 'unemployed'
      education: 'none'
      level: 0
      points: 0
      followers: 0
      spells: {}

  mutations:
    load: (state, player) ->
      state.player = player

  actions:
    loadUser: ({commit}, id) ->
      axios.get("/api/v1/users/#{id}").then (response) =>
        commit('load', response.data)

    castSpell: ({commit}, options) ->
      axios.post("/api/v1/users/#{options.id}/cast", options).then (response) =>
        console.log response.data
)

export {store as default}
