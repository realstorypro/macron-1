import Vuex from 'vuex'
import axios from 'axios'


store = new (Vuex.Store)(
  state:
    user: {}
    entry: {}

  mutations:
    load: (state, user) ->
      state.user = user

    loadEntry: (state, entry) ->
      state.entry = entry

    updateEnergy: (state, energy) ->
      state.user.energy = energy

  actions:
    loadUser: ({commit}, id) ->
      axios.get("/api/v1/users/#{id}").then (response) =>
        commit('load', response.data)

    loadEntry: ({commit}, options) ->
      axios.get("/api/v1/entries/#{options.id}/",
        params: {component: options.component}
      ).then (response) =>
        commit('loadEntry', response.data)

    castSpell: ({commit}, options) ->
      axios.post("/api/v1/users/#{options.id}/cast", options).then (response) =>

    reduceEnergy:({commit, state}, amount) ->
      commit 'updateEnergy', (state.user.energy - amount)

)

export {store as default}
