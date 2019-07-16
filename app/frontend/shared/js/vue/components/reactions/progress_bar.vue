<template lang="pug">
    .ui.progress(v-bind:class="[color]")
        .label {{ label }}
        .bar(v-bind:style="{width: progress}")
            .progress

</template>

<script lang="coffee">

    export default
        props:
            label: String
            color: String
            percent: Number
        computed:
            progress: ->
                @percent + '%'

</script>

<style lang="sass" scoped>
    .label
        top: 0 !important
        z-index: 1
        color: white !important
    .ui.progress
        margin-top: 0.90em !important
        margin-bottom: 0.90em !important
        background: rgba(0, 0, 0, 0.75) !important

    .bar
        transition: 1.0s all
        min-width: 3px !important

    .activecast .bar
        width: 100% !important
        animation-name: bgPulse
        animation-duration: 1s
        animation-iteration-count: infinite
</style>
