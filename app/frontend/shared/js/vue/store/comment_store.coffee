import axios from 'axios'
import Vuex from 'vuex'
import _ from 'underscore'

store = new (Vuex.Store)(
  state:
    new_comments: []
    comments: []
    loading: false
    appending: false

  mutations:
    load: (state, comments) ->
      state.comments = comments

    deleteComment: (state, comment) ->
      state.comments = _.without(state.comments, comment)

  actions:
    loadComments: ({commit}, {component, record}) ->
      axios.get("/comments/",
        params:
          component: component
          record_id: record
      ).then (response) =>
        commit('load', response.data.comments)

    destroyComment: ({commit}, {component, record, comment}) ->
      axios.delete("/comments/#{comment.id}"
        params:
          component: component
          record_id: record
      ).then((response) =>
        commit('deleteComment', comment)
      ).catch((response) =>
        console.log response
      )

    subscribeToUpdates: ({commit}, {component, record})->
      cable.subscriptions.create { channel: 'CommentChannel', component: component, record: record},
        received: (data) ->
          commit('add_new_comment', data.comment_id)

)

export {store as default}
