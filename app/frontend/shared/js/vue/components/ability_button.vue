<template lang="pug">
    .ability
        .ui.icon.button(v-bind:class="[color, {processing: processing}]" @mousedown="onMouseDown" @mouseup="onMouseUp" @mouseover="onMouseOver" @mouseout="onMouseOut")
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
            castInterval: 100
            processing: false
        computed:
            completed_percent: ->
                percent = Math.floor(@currentCastTime/@castTime*100)
                console.log @currentCastTime, @castTime, percent
                percent
        methods:
            onMouseOver: ->
                @.$emit('use-ability', @access_key)

            onMouseDown: ->
                console.log 'mouseDOWN'
                @currentCastTime = 0
                @processing = true
                @interval = setInterval(@castCounter,@castInterval)

            onMouseUp: ->
                @stopCasting()
                @stopCounter()

            onMouseOut: ->
                @stopCasting()
                @stopCounter()
                @.$emit('use-ability', null)

            castCounter: ->
                if @currentCastTime + @castInterval >= @castTime
                    @.$emit('casting', 100)
                    @stopCounter()
                else
                    @currentCastTime += @castInterval
                    console.log @completed_percent
                    @.$emit('casting', @completed_percent)

            stopCounter: ->
                clearInterval(@interval)

            stopCasting: ->
                @processing = false
                @.$emit('casting', 0)


</script>

<style lang="sass" scoped>
    .ability
        display: inline-block
        margin-right: 0.5em
</style>
