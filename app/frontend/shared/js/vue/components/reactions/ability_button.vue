<template lang="pug">
    .ability
        .ui.icon.button(v-bind:class="[color, {processing: processing}, {active_cast: activeCast && processing}]" @mousedown="onMouseDown" @mouseup="onMouseUp" @mouseover="onMouseOver" @mouseout="onMouseOut")
            i.icon.normal.inverted(v-bind:class="icon")
</template>

<script lang="coffee">
    export default
        props:
            icon: String
            color: String
            castTime: Number
            access_key: String
            activeCast: Boolean
        data: ->
            currentCastTime: 0
            castInterval: 70
            processing: false
            active: false
            interval: ''
        computed:
            completed_percent: ->
                percent = Math.floor(@currentCastTime/@castTime*100)
                percent
        methods:
            onMouseOver: ->
                @.$emit('use-ability', @access_key)

            onMouseDown: ->
                @startCasting()

            onMouseUp: ->
                @stopCasting()
                @stopCounter()

            onMouseOut: ->
                @stopCasting()
                @stopCounter()
                @.$emit('use-ability', null)

            onTap: ->

                console.log 'active: ' ,@active
                if !@active
                    @startCasting()
                else
                    @stopCasting()
                    @stopCounter()

                @active = !@active


            castCounter: ->
                console.log 'counter tick'
                console.log 'interval tick', window.interval
                if (@currentCastTime + @castInterval >= @castTime) || (@completed_percent == 100)
                    @.$emit('casting', 100)
                    @stopCounter()
                else
                    @currentCastTime += @castInterval
                    @.$emit('casting', @completed_percent)

            stopCounter: ->
                clearInterval(window.interval)

            stopCasting: ->
                @currentCastTime = 0
                @processing = false
                @.$emit('casting', 0)

            startCasting: ->
                @currentCastTime = 0
                @processing = true
                window.interval = setInterval(@castCounter,@castInterval)


</script>

<style lang="sass" scoped>
    @-webkit-keyframes bgPulse
        from
            box-shadow: 0 0 9px #21BA45
        50%
            box-shadow: 0 0 12px #91bd09
        to
            box-shadow: 0 0 9px #21BA45

    @-webkit-keyframes borderPulse
        from
            border: 2px solid #21BA45
        50%
            border: 2px solid #00d8ff
        to
            border: 2px solid #21BA45

    .ability
        display: inline-block
        margin-right: 0.5em

    .processing
        animation-name: bgPulse
        animation-duration: 2s
        animation-iteration-count: infinite

    .active_cast
        background: #0d71bb !important

</style>
