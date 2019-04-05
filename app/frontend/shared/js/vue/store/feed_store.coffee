import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import axios from 'axios'
import Cable from '../../core/cable'

cable = (new Cable).cable

Vue.use(Vuex)

store = new (Vuex.Store)(
  state:
    activities: []
    loading: false

  mutations:
    load: (state, activities) ->
      state.activities = activities

    add: (state, activity) ->
      state.activities.push activity

  actions:
    # TODO: Modify to pull in an actual user
    loadActivities: ({commit}, {user_id}) ->
      axios.get('/api/v1/activities/').then (response) =>
        commit('load', response.data.activities)

    loadActivity: ({commit}, {user_id})->
      console.log 'load an activity'

    subscribeToUpdaes: ({commit}, {user_id})->
      window.cable = cable
      cable.subscriptions.create { channel: 'ActivityChannel', user_id: user_id },
        received: (data) ->
          console.log 'received data', data

)

export {store as default}
