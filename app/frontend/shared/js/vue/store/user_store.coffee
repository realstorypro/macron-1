import Vuex from 'vuex'
import axios from 'axios'


store = new (Vuex.Store)(
  state:
    user:
      username: 'guest'
      job: 'unemployed'
      education: 'none'
      level: 0
      points: 0
      followers: 0
      spells: {}
    world: {}

  mutations:
    load: (state, user) ->
      state.user = user

    loadWorld: (state, world) ->
      state.world = world

  actions:
    loadUser: ({commit}, id) ->
      axios.get("/api/v1/users/#{id}").then (response) =>
        commit('load', response.data)

    loadWorld: ({commit}, options) ->
      axios.get("/api/v1/entries/#{options.id}/",
        params: {component: options.component}
      ).then (response) =>
        commit('loadWorld', response.data)

    castSpell: ({commit}, options) ->
      axios.post("/api/v1/users/#{options.id}/cast", options).then (response) =>
)

export {store as default}
