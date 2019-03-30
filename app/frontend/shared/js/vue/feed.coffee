import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'
import stream from 'getstream'

utils = new Utils
vent = new Vent

class Feed
  instance = null
  app = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

    vent.channel().on "vue:feed", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'feed'

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      mounted: ->
        @token =  $(@.$options.el).data('stream-token')
        @readonly_token =  $(@.$options.el).data('stream-readonly-token')
        @api_key = $(@.$options.el).data('stream-api')
        @user_id = $(@.$options.el).data('user-id')

        @client = stream.connect(@api_key, @token)
        @user_feed = @client.feed('user', @user_id)
        @user_feed.get({limit:5}).then (body)->
          console.log body


export { Feed as default }
