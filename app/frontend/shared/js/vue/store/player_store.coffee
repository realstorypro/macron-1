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
    world: {}

  mutations:
    load: (state, player) ->
      state.player = player

    loadWorld: (state, world) ->
      state.world = world

  actions:
    loadPlayer: ({commit}, id) ->
      axios.get("/api/v1/players/#{id}").then (response) =>
        commit('load', response.data)

    loadWorld: ({commit}, options) ->
      axios.get("/api/v1/world/#{options.id}/",
        params: {component: options.component}
      ).then (response) =>
        commit('loadWorld', response.data)

    castSpell: ({commit}, options) ->
      axios.post("/api/v1/players/#{options.id}/cast", options).then (response) =>
        console.log response.data
)

export {store as default}
