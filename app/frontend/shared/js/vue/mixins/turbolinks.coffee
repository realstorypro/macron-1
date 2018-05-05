module.exports =
  beforeMount: ->
    document.addEventListener 'turbolinks:before-cache', () =>
      @.$destroy()

    @.$originalEl = @.$el.outerHTML

  destroyed: ->
    @.$el.outerHTML = @.$originalEl
