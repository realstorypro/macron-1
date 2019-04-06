import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'
import store from './store/feed_store'
import axios from 'axios'
import moment from 'moment'

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

        store.dispatch('subscribeToUpdaes', { @user_id })
        store.dispatch('loadActivities', { @user_id })

      computed:
        activities: ->
          store.state.activities

        count: ->
          store.state.activities.length

        prepending: ->
          return "disabled loading" if store.state.prepending
          return "" unless store.state.prepending

        appending: ->
          return "disabled loading" if store.state.appending
          return "" unless store.state.appending


        new_activities_count: ->
          store.state.new_activities.length

      methods:
        load_new_activities: ->
          store.dispatch('loadNewActivities', { @user_id })

        load_more_activities: ->
          store.dispatch('loadMoreActivities', { @user_id })



      filters:
        calendar_date: (datestamp) ->
          moment(datestamp).calendar()

        short_date: (datestamp) ->
          moment(datestamp).format('MMMM YYYY')


export { Feed as default }
