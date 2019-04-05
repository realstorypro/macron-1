import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import axios from 'axios'
import Cable from '../../core/cable'

cable = (new Cable).cable

Vue.use(Vuex)

store = new (Vuex.Store)(
  state:
    new_activities: []
    activities: []
    loading: false

  mutations:
    load: (state, activities) ->
      state.activities = activities

    add: (state, activities) ->
      for activity in activities
        state.activities.unshift(activity)

    add_new_activity: (state, activity_id) ->
      state.new_activities.push activity_id

    clear_new_activities: (state) ->
      state.new_activities = []


  actions:
    # TODO: Modify to pull in an actual user
    loadActivities: ({commit}, {user_id}) ->
      axios.get("/api/v1/activities/#{user_id}").then (response) =>
        commit('load', response.data)

    loadNewActivities: ({commit, state}, {user_id})->
      axios.get("/api/v1/activities/#{user_id}"
        params:
          activities: state.new_activities
      ).then (response) =>
        commit('clear_new_activities')
        commit('add', response.data)

    subscribeToUpdaes: ({commit}, {user_id})->
      cable.subscriptions.create { channel: 'ActivityChannel', user_id: user_id },
        received: (data) ->
          commit('add_new_activity', data.activity_id)

)

export {store as default}
