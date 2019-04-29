<template lang="pug">
    .ui.progress(v-bind:class="color")
        .label {{ label }}
        .bar(v-bind:style="{width: progress}")
            .progress

</template>

<script lang="coffee">

    export default
        props:
            label: String
            color: String
            start: Number
            end: Number
            current: Number
        computed:
            progress: ->
                @current/@end*100 + '%'

</script>

<style lang="sass" scoped>
    .label
        top: 0 !important
        z-index: 1
        color: white !important
    .ui.progress
        margin-bottom: 1.5em !important
        background: rgba(0, 0, 0, 0.75) !important
</style>
