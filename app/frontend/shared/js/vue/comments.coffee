import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'

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
      mixins: [turbolinks_adapter]
      components: { avatar, dropdown }
      data:
        comment_empty: true
        comments: []
        current_user: $("##{widget.id}").data('user')
        component: $("##{widget.id}").data('component')
        record: $("##{widget.id}").data('record')

      mounted: ->
        $R.options =
          minHeight: '180px'
          toolbarFixed: false
          autoparseVideo: false
          buttons: ['format','bold','ul','line']
          buttonsHideOnMobile: ['format','ul','line']
          formatting: ['p']
          formattingAdd:
            "large-header":
              title: 'Large Header',
              api: 'module.block.format',
              args:
                'tag': 'h2'
            "small-header":
              title: 'Small Header',
              api: 'module.block.format',
              args:
                'tag': 'h4'


        $R "##{widget.id} .comment.box",
          placeholder: "Type your reply here ..."
          callbacks:
            keyup: (e)=>
              @comment_empty = $R("##{widget.id} .comment.box").editor.isEmpty()



      created: ->
          axios.get('/comments/',
            params:
              component: @component
              record_id: @record
          ).then (response) =>
            @comments = response.data.comments
            $("##{widget.id}").removeClass('hidden')


      filters:
        calendar_date: (datestamp) ->
          moment(datestamp).calendar()

        short_date: (datestamp) ->
          moment(datestamp).format('MMMM YYYY')

      methods:
        add_comment: (e) ->
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

        reset_comment_box: (e) ->
          $R("##{widget.id} .comment.box").source.setCode('')

        destroy_comment: (comment) ->
          axios.delete("/comments/#{comment.id}"
            params:
              component: @component
              record_id: @record
          ).then((response) =>
            @comments = _.without(@comments, comment)
          ).catch((response) =>
            console.log response
          )

        profile_link: (user) ->
          if @current_user == user.id
            "/profile/"
          else
            "/members/#{user.slug}"

export { Comments as default }
