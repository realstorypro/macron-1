<template lang="pug">
    .ability
        .ui.icon.button(v-bind:class="[color, disabled]" @mousedown="onMouseDown" @mouseup="onMouseUp" @mouseover="onMouseOver" @mouseout="onMouseOut")
            i.icon.normal.inverted(v-bind:class="icon")
</template>

<script lang="coffee">
    export default
        props:
            label: String
            icon: String
            color: String
            castTime: Number
            access_key: String
        data: ->
            currentCastTime: 0
            castInterval: 50
            disabled: false
        methods:
            onMouseDown: ->
                @disabled = true
                @interval = setInterval(@castCounter,@castInterval)
            onMouseUp: ->
                @stopCounter
            onMouseOver: ->
                @.$emit('use-ability', @access_key)
            onMouseOut: ->
                @.$emit('use-ability', null)
                @stopCounter

            castCounter: ->
                if @currentCastTime + @castInterval >= @castTime
                    @stopCounter()
                else
                    @currentCastTime += @castInterval
                    @.$emit('casting', @castTime)
                    @.$emit('status', 'cast')
                    @onMouseUp

            stopCounter: ->
                clearInterval(@interval)
                @currentCastTime = 0
                @.$emit('casting', @currentCastTime)

</script>

<style lang="sass" scoped>
    .ability
        display: inline-block
        margin-right: 0.5em
</style>
