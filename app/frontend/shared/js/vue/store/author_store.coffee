import Vuex from 'vuex'
import axios from 'axios'


store = new (Vuex.Store)(
  state:
    player:
      first_name: 'Guest'
      last_name: 'User'
      username: 'Guest'
      job: 'Unemployed'
      education: 'High School'
      level: 0
      points: 0
      supporters: 0
      spells: {}
      paths: []

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
