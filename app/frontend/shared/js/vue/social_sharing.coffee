import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'
import VueGoodshareTumblr from 'vue-goodshare/src/providers/Tumblr.vue'
import VueGoodshareFacebook from 'vue-goodshare/src/providers/Facebook.vue'
import VueGoodshareTwitter from 'vue-goodshare/src/providers/Twitter.vue'
import VueGoodshareLinkedin from 'vue-goodshare/src/providers/LinkedIn.vue'
import VueGoodshareReddit from 'vue-goodshare/src/providers/Reddit.vue'
import VueGoodsharePinterest from 'vue-goodshare/src/providers/Pinterest.vue'

utils = new Utils
vent = new Vent

class SocialSharing
  instance = null
  app = null


  constructor: ->
    if !instance
      instance = this

    else
      instance

    vent.channel().on "vue:social_sharing", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'social_sharing'

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      components: { VueGoodshareTumblr,VueGoodshareFacebook, VueGoodshareTwitter, VueGoodshareLinkedin, VueGoodshareReddit, VueGoodsharePinterest }
      data:
        flipped: false

      mounted: ->
        console.log 'mounted'
      methods:
        flip_card: () ->
          @flipped = true

export { SocialSharing as default }
