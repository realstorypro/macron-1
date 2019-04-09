module.exports =
  data:
    passed: {}
  mounted: ->
    console.log @.$el, @
    @.passed = $("#{@.$options.el}").data()
    console.log @.$el, @
