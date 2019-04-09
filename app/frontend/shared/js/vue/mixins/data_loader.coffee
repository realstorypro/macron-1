module.exports =
  data:
    passed: {}
  mounted: ->
    @.passed = $("#{@.$options.el}").data()
