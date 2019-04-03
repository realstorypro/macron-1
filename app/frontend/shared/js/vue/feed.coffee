import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'
import store from './store/feed_store'
import axios from 'axios'

utils = new Utils
vent = new Vent


class Feed
  instance = null
  app = null

  token = document.getElementsByName('csrf-token')[0].content
  axios.defaults.headers.common['X-CSRF-Token'] = token
  axios.defaults.headers.common['Accept'] = 'application/json'

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
        @user_id = $(@.$options.el).data('user-id')
        store.dispatch('loadActivities', { @user_id })

      computed:
        activities: ->
          store.state.activities


export { Feed as default }
