import Utils from '../core/utils'
import Vent from '../core/vent'
import Vue from 'vue/dist/vue.esm'
import turbolinks_adapter from './mixins/turbolinks'

utils = new Utils
vent = new Vent

class CategoryFilter
  instance = null
  app = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

    vent.channel().on "vue:category_filter", (widget, action) =>

      switch action
        when 'setup' then @setup(widget)

  setup: (widget) ->
    utils.log 'setup', 'setup()', 'category_filter'

    @app = new Vue
      el: "##{widget.id}"
      mixins: [turbolinks_adapter]
      props:
        component_path: ''
      mounted: ->
        @component_path = $("##{widget.id}").data('componentPath')
        $(@.$options.el).find('.dropdown').dropdown()

      methods:
        change_category: (val) ->
          Turbolinks.visit "/#{@component_path}/#{val}"

export { CategoryFilter as default }
