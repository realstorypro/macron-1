import Vuex from 'vuex'
import axios from 'axios'


store = new (Vuex.Store)(
  state:
    entry: {}

  mutations:
    loadEntry: (state, entry) ->
      state.entry = entry

  actions:
    loadEntry: ({commit}, options) ->
      axios.get("/api/v1/entries/#{options.id}/",
        params: {component: options.component}
      ).then (response) =>
        commit('loadEntry', response.data)
)

export {store as default}
