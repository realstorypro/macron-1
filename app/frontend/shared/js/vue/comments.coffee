import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'

import store from './store/comment_store'
import axios from 'axios'
import moment from 'moment'
import _ from 'underscore'

import avatar from 'vue-avatar'
import dropdown from './components/dropdown'

import redactor from '../plugins/redactor/redactor'

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
      components: { avatar, dropdown }
      data:
        comment_empty: true
        # comments: []
        current_user: $("##{widget.id}").data('user')
        component: $("##{widget.id}").data('component')
        record: $("##{widget.id}").data('record')

      mounted: ->
        store.dispatch('subscribeToUpdates', { @component, @record })
        store.dispatch('loadComments', { @component, @record })

        $R.options =
          minHeight: '180px'
          toolbarFixed: false
          autoparseVideo: false
          buttons: ['format','bold','ul','line']
          buttonsHideOnMobile: ['format','ul','line']
          formatting: ['p']
          formattingAdd:
            "small-header":
              title: 'Normal',
              api: 'module.block.format',
              args:
                'tag': 'p'
            "small-header":
              title: 'Medium',
              api: 'module.block.format',
              args:
                'tag': 'h4'
            "large-header":
              title: 'Large',
              api: 'module.block.format',
              args:
                'tag': 'h2'


        $R "##{widget.id} .comment.box",
          placeholder: "Type your reply here ..."
          callbacks:
            keyup: (e)=>
              @comment_empty = $R("##{widget.id} .comment.box").editor.isEmpty()



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
        addComment: (e) ->
          comment_text = $R("##{widget.id} .comment.box", 'source.getCode')

          if comment_text != ''
            axios.post("/comments/",
              component: @component
              record_id: @record
              body: comment_text
            ).then((response) =>
              @comments.push response.data
              $R("##{widget.id} .comment.box").source.setCode('')

              $('html, body').animate { scrollTop: $('.posts').offset().top + $('.posts').outerHeight(true) - 100 }, 800


              comment_text = ''
              @comment_empty = true
            ).catch((response) =>
              console.log response
            )
          else
            console.log 'the comment can not be empty!'

        destroy_comment: (comment) ->
          store.dispatch('destroyComment', { @component, @record, comment })

        profile_link: (user) ->
          if @current_user == user.id
            "/profile/"
          else
            "/members/#{user.slug}"

export { Comments as default }
