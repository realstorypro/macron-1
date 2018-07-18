import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'

import axios from 'axios'

utils = new Utils
vent = new Vent

class Newsletter
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

    vent.channel().on "vue:newsletter", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'newsletter'


    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]

      props:
        email: ''
      data: ->
        response: {}
        errorMessage: null
        successMessage: null
        sending : false
        hardcodedSuccessMessage: "You've been added to our mailing list. Thank you for subscribing!"
        hardcodedErrorMessage: 'Unable to add subscription. Please try again later.'
      mounted: ->
        @email = $("##{widget.id}").data('email')

      created: ->
        $("##{widget.id}").removeClass('hidden')

      methods:
        subscribe: (e) ->
          params = $(e.currentTarget).serialize()
          @sending = true

          axios.post("/newsletter/subscribe", params).then((response) =>
            @successMessage = true

          ).catch((reponse) =>
            @errorMessage = true
            @sending = false
          )

export { Newsletter as default }
