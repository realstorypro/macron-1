<template lang="pug">
  h1 hello world
</template>

<script lang="coffee">
    module.exports =
        props:
            avatar: ''
        data: -> {}
        mounted: ->
            console.log 'we mount'
</script>

<style lang="sass">
  h1
      font-size: 2em
</style>
