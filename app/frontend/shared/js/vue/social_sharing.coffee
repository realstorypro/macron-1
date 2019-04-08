import Vue from 'vue/dist/vue.esm'
import Common from '../core/common'
import turbolinks_adapter from './mixins/turbolinks'
import data_loader from './mixins/data_loader'
import VueGoodshareTumblr from 'vue-goodshare/src/providers/Tumblr.vue'
import VueGoodshareFacebook from 'vue-goodshare/src/providers/Facebook.vue'
import VueGoodshareTwitter from 'vue-goodshare/src/providers/Twitter.vue'
import VueGoodshareLinkedin from 'vue-goodshare/src/providers/LinkedIn.vue'
import VueGoodshareReddit from 'vue-goodshare/src/providers/Reddit.vue'
import VueGoodsharePinterest from 'vue-goodshare/src/providers/Pinterest.vue'


class SocialSharing extends Common

  constructor: ->
    super('social_sharing')

  setup: (widget) ->

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter, data_loader]
      components: { VueGoodshareTumblr,VueGoodshareFacebook, VueGoodshareTwitter, VueGoodshareLinkedin, VueGoodshareReddit, VueGoodsharePinterest }
      data:
        flipped: false

      methods:
        flip_card: () ->
          @flipped = true

export { SocialSharing as default }
