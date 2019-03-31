import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'
import store from './store/feed_store'

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
        @api_key = $(@.$options.el).data('stream-api')
        @user_id = $(@.$options.el).data('user-id')
        store.dispatch('loadActivities', { @token, @api_key, @user_id })

      computed:
        activities: ->
          store.state.activities
        count: ->
          store.state.activities.length


export { Feed as default }
