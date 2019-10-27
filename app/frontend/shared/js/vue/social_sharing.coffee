import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import VueGoodshareTumblr from 'vue-goodshare/src/providers/Tumblr.vue'
import VueGoodshareFacebook from 'vue-goodshare/src/providers/Facebook.vue'
import VueGoodshareTwitter from 'vue-goodshare/src/providers/Twitter.vue'
import VueGoodshareLinkedin from 'vue-goodshare/src/providers/LinkedIn.vue'
import VueGoodshareReddit from 'vue-goodshare/src/providers/Reddit.vue'
import VueGoodsharePinterest from 'vue-goodshare/src/providers/Pinterest.vue'


class SocialSharing extends Common

  constructor: ->
    if !instance
      @register_events('social_sharing')
      instance = this
    else
      instance

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      components: { VueGoodshareTumblr,VueGoodshareFacebook, VueGoodshareTwitter, VueGoodshareLinkedin, VueGoodshareReddit, VueGoodsharePinterest }
      data:
        flipped: false

      methods:
        flip_card: () ->
          @flipped = true

export { SocialSharing as default }
