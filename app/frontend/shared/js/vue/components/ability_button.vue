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
                clearInterval(@interval)
                @currentCastTime = 0
            onMouseOver: ->
                @.$emit('use-ability', @access_key)
            onMouseOut: ->
                @.$emit('use-ability', null)
                clearInterval(@interval)
                @currentCastTime = 0
            castCounter: ->
                final_count = false
                final_count = true if @currentCastTime + @castInterval >= @castTime

                if final_count
                    @currentCastTime += @castInterval
                    @.$emit('casting', @currentCastTime)
                else
                    @.$emit('casting', @castTime)
                    @.$emit('status', 'cast')
                    @onMouseUp

</script>

<style lang="sass" scoped>
    .ability
        display: inline-block
        margin-right: 0.5em
</style>
