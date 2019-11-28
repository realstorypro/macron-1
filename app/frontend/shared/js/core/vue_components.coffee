# Used to Import Global Components to Vue
import Vue from 'vue/dist/vue.esm'

import TurbolinksAdapter from 'vue-turbolinks'
import VModal from 'vue-js-modal'
import Vuex from 'vuex'
import VTooltip from 'v-tooltip'
import Vue2TouchEvents from 'vue2-touch-events'
import VuePluralize from 'vue-pluralize'
import VueTouch from 'vue-touch'
import ToggleButton from 'vue-js-toggle-button'
import Notifications from 'vue-notification'
import velocity      from 'velocity-animate'
import VuePlyr from 'vue-plyr'
import VueCookies from 'vue-cookies'

Vue.use(TurbolinksAdapter)
Vue.use(VModal)
Vue.use(Vuex)
Vue.use(VTooltip)
Vue.use(Vue2TouchEvents)
Vue.use(VuePluralize)
Vue.use(VueTouch)
Vue.use(ToggleButton)
Vue.use(Notifications, {velocity})
Vue.use(VuePlyr)
Vue.use(VueCookies)
