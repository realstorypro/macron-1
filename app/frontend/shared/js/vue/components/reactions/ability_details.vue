<template lang="pug">
    .wrapper
        h5.ui.header
            i.icon.huge(v-bind:class='[icon, color]')
            .content {{ name }}
        .detail-wrapper(v-bind:class='[color]')
            .direction(v-bind:class='[color]')
                | {{ directionSign }}
            .points(v-bind:class='[color]')
                .low {{ points.low }}
                .high {{ points.high }}
            .details
                p.text {{ description}}
</template>

<script lang="coffee">
    export default
        props:
            name: String
            description: String
            icon: String
            color: String
            points: Object
            direction: String
        computed:
            directionSign: ->
                return "+" if @direction is 'positive'
                return "-" if @direction is 'negative'

</script>

<style lang="sass" scoped>
    $red: red
    $green: green
    $blue: blue

    .wrapper
        min-height: 120px

        .header
            margin-top: 1em

        .detail-wrapper
            display: flex
            padding-top: 1em

            &.green
                border-top: 2px solid $green

            &.red
                border-top: 2px solid $red

            &.blue
                border-top: 2px solid $blue

        .direction
            display: flex
            flex: 1%
            font-size: 1.1em
            font-weight: bold
            justify-content: center
            flex-direction: column

        .points
            display: flex
            flex: 12%
            font-size: 1.2em
            text-align: center
            justify-content: center
            flex-direction: column
        .details
            flex: 85%

            p
                color: black

        .green
           color: $green

        .red
            color: $red

        .blue
            color: $blue
</style>
