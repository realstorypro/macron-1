import axios from 'axios'
import Vuex from 'vuex'

store = new (Vuex.Store)(
  state:
    new_comments: []
    comments: []
    loading: false
    appending: false

  mutations:
    load: (state, comments) ->
      state.comments = comments

    # append_comments: (state, comments) ->
    #   for comment in comments
    #     state.comments.push(comment)

    # add_new_comment: (state, comment_id) ->
    #   state.new_comments.push comment_id

    # clear_new_comments: (state) ->
    #   state.new_comments = []

    # start_appending_comments: (state) ->
    #   state.appending = true

    # stop_appending_comments: (state) ->
    #   state.appending = false

  actions:
    loadComments: ({commit}, {component, record}) ->
      axios.get("/comments/",
        params:
          component: component
          record_id: record
      ).then (response) =>
        commit('load', response.data.comments)

    # loadNewComments: ({commit, state}, {user_id})->
    #   axios.get("/api/v1/comments/#{user_id}"
    #     params:
    #       comments: state.new_comments
    #   ).then (response) =>
    #     commit('clear_new_comments')
    #      commit('append_comments', response.data)

    subscribeToUpdates: ({commit}, {component, record})->
      cable.subscriptions.create { channel: 'CommentChannel', component: component, record: record},
        received: (data) ->
          commit('add_new_comment', data.comment_id)

)

export {store as default}
