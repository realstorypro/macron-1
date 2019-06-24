<template lang="pug">
    .wrapper
        h5.ui.header
            i.icon.huge(v-bind:class='[icon, color]')
            .content {{ name }}
        .detail-wrapper
            .direction(v-bind:class='[color]')
                | {{ directionSign }}
            .points(v-bind:class='[color]')
                .low {{ points.low }}
                .high {{ points.high }}
            .details-text
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
