<template lang="pug">
    v-popover(class="entry points" name="supapopover" placement="top" trigger="hover" delay="400")
        span.spell.point
            animated-number(:value="points" :format-value="formatToInt" :duration="400")
            i.icon(v-bind:class="[icon, color]")
        template(slot="popover" class="yellow")
            .point.details
                .ui.grid
                    .column.sixteen.wide
                        h5.ui.header.dividing(:class="color")
                            i.icon(v-bind:class="[icon, color]")
                            | {{ name }}
                        p {{ description }}
</template>

<script lang="coffee">
    import AnimatedNumber from "animated-number-vue"
    import { VTooltip, VPopover, VClosePopover } from 'v-tooltip'

    export default
        props:
            name: String
            description: String
            icon: String
            color: String
            points: Number
        components:
            'animated-number': AnimatedNumber
            'v-popover': VPopover
        directives:
            'tooltip': VTooltip
            'close-popover': VClosePopover
        methods:
            formatToInt: (value) ->
                if value > 1000
                    "#{Number(value/1000).toFixed(1)}k"
                else
                    Number(value).toFixed(0)
</script>

<style lang="sass" scoped>
    .point.details
        padding: 1.5em 1em
</style>
