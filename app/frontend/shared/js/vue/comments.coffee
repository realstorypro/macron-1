import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'

import store from './store/comment_store'
import axios from 'axios'
import moment from 'moment'
import _ from 'underscore'

import avatar from 'vue-avatar'
import dropdown from './components/dropdown'

# Factor In
import EditorComponent from './components/editor'

utils = new Utils
vent = new Vent

class Comments
  instance = null
  app = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

    vent.channel().on "vue:comments", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'comments'

    @app = new Vue
      el: "##{widget.id}"
      data:
        comment_empty: true
        current_user: $("##{widget.id}").data('user')
        component: $("##{widget.id}").data('component')
        record: $("##{widget.id}").data('record')
      components: {'editor-component': EditorComponent, 'avatar': avatar, 'dropdown': dropdown}
      mounted: ->
        store.dispatch('subscribeToUpdates', { @component, @record })
        store.dispatch('loadComments', { @component, @record })

      computed:
        comments: ->
          store.state.comments

        count: ->
          store.state.comments.length

      created: ->
          $("##{widget.id}").removeClass('hidden')


      filters:
        calendar_date: (datestamp) ->
          moment(datestamp).calendar()

        short_date: (datestamp) ->
          moment(datestamp).format('MMMM YYYY')

      methods:
        postReply: (reply) ->
          if reply != ''
            axios.post("/comments/",
              component: @component
              record_id: @record
              body: reply
            ).then((response) =>
              @comments.push response.data
            ).catch((response) =>
              console.log response
            )
        destroy_comment: (comment) ->
          store.dispatch('destroyComment', { @component, @record, comment })

        profile_link: (user) ->
          if @current_user == user.id
            "/profile/"
          else
            "/members/#{user.slug}"

export { Comments as default }
