import Vue from 'vue/dist/vue.esm'
import axios from 'axios'
import Vuex from 'vuex'

store = new (Vuex.Store)(
  state:
    new_activities: []
    activities: []
    loading: false
    prepending: false
    appending: false

  mutations:
    load: (state, activities) ->
      state.activities = activities

    prepend_activities: (state, activities) ->
      for activity in activities
        state.activities.unshift(activity)

    append_activities: (state, activities) ->
      for activity in activities
        state.activities.push(activity)

    add_new_activity: (state, activity_id) ->
      state.new_activities.push activity_id

    clear_new_activities: (state) ->
      state.new_activities = []

    start_appending_activities: (state) ->
      state.appending = true

    stop_appending_activities: (state) ->
      state.appending = false

    start_prepending_activities: (state) ->
      state.prepending = true

    stop_prepending_activities: (state) ->
      state.prepending = false

  actions:
    loadActivities: ({commit}, {user_id}) ->
      axios.get("/api/v1/activities/#{user_id}").then (response) =>
        console.log response.data
        commit('load', response.data)

    loadNewActivities: ({commit, state}, {user_id})->
      commit('start_prepending_activities')
      axios.get("/api/v1/activities/#{user_id}"
        params:
          activities: state.new_activities
      ).then (response) =>
        commit('clear_new_activities')
        commit('prepend_activities', response.data)
        commit('stop_prepending_activities')

    loadMoreActivities: ({commit, state}, {user_id}) ->
      commit('start_appending_activities')
      axios.get("/api/v1/activities/#{user_id}"
        params:
          offset: (state.activities.length + state.new_activities.length)
      ).then (response) =>
        commit('append_activities', response.data)
        commit('stop_appending_activities')

    subscribeToUpdaes: ({commit}, {user_id})->
      cable.subscriptions.create { channel: 'ActivityChannel', user_id: user_id },
        received: (data) ->
          commit('add_new_activity', data.activity_id)

)

export {store as default}
