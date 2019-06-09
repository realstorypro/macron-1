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
)

export {store as default}
