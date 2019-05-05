import Utils from '../core/utils'
import Vent from '../core/vent'


import GlobalVue from 'vue/dist/vue.esm'
import Vue2TouchEvents from 'vue2-touch-events'

GlobalVue.use(Vue2TouchEvents)

utils =  new Utils
vent =  new Vent

class Vue

  instance = null

  # implementing singleton pattern
  constructor : () ->

    if !instance
      instance = this

    else
      instance

  setup : () ->
    utils.log 'setup', 'setup()', 'vue widget starter'

    $ =>
      $('[data-vue]').each (index, object) =>

        widget =
          id: $(object).attr('id')
          name: $(object).data('name')

        vent.channel().trigger "vue:#{widget.name}", widget, 'setup'

export { Vue as default }
