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
    loadPlayer: ({commit}, id) ->
      axios.get("/api/v1/players/#{id}").then (response) =>
        commit('load', response.data)

    # TODO: Rrefactor to just use IDs
    castSpell: ({commit}, options) ->
      axios.post("/api/v1/players/#{options.id}cast", options).then (response) =>
        console.log response.data
)

export {store as default}
