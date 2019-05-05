<template lang="pug">
    .wrapper
        h5.ui.header
            i.icon.huge.hand.pointing.up
            .content Select an Ability
        .detail-wrapper(v-bind:class='[color]')
            .details
                p.text Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat et arcu nec venenatis.
</template>

<script lang="coffee">
    export default
        data: {}
</script>

<style lang="sass" scoped>
    .wrapper
        min-height: 120px

    .detail-wrapper
        display: flex
        padding-top: 1em
        border-top: 2px solid black

    .details
        flex: 85%

        p
            color: black
</style>
