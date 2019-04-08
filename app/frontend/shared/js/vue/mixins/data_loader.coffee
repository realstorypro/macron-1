module.exports =
  mounted: ->
    console.log $("#{@.$options.el}")
    window.el = @
