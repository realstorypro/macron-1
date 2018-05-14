import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'
import axios from 'axios'

utils = new Utils
vent = new Vent

class Embed
  instance = null
  app = null


  constructor: ->
    if !instance
      instance = this

    else
      instance

    vent.channel().on "vue:embed", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'embed'

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      props:
        url: ''
      mounted: ->
        @url = $("##{widget.id}").data('url')
        axios.get('https://iframe.ly/api/oembed',
          params:
            url: @url
            api_key: '68015f79a8e4546f14fbc9'
        ).then (response) =>
          $("##{widget.id}").html(response.data.html)

export { Embed as default }
