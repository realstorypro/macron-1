<template lang="jade">
    <div class="ui dropdown">
        <slot></slot>
    </div>
</template>

<script lang="coffee">
    module.exports =
        data: -> {}
        mounted: ->
            $(@.$el).dropdown()
</script>
