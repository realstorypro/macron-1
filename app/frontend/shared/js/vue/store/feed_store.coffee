import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import axios from 'axios'

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
    loadActivities: ({commit}, {user_id}) ->
      axios.get('/api/v1/activities/').then (response) =>
        console.log response.data.activities
        commit('load', response.data.activities)

      # client = stream.connect(api_key, token, 49865)
      # user_feed = client.feed('user', user_id)

      #user_feed.get({limit:5}).then (body) ->
      #  commit('load', body.results)
)

window.store = store
export {store as default}
