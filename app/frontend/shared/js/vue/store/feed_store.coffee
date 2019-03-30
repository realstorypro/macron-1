import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import stream from 'getstream'

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
    loadActivities: ({commit}, {token, api_key, user_id}) ->
      client = stream.connect(api_key, token, 49865)
      user_feed = client.feed('user', user_id)

      subscription = user_feed.subscribe (data) ->
        new_activity = data.new[0]
        commit('add', new_activity)

      user_feed.get({limit:5}).then (body) ->
        commit('load', body.results)
)

window.store = store
export {store as default}
