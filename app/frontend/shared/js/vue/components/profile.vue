<template lang="pug">
.wrapper
    .top.meta
        a.author(:href="url")
            | {{username}}
            .verified(v-if='verified')
                i.icon.check.mark.circular.mini.inverted.yellow
        .level
            | Level {{level}}
    a(:href="url")
        avatar(v-bind:username='username' v-bind:src='avatar' :rounded='true' :size='50')
    .bottom.meta
        i.icon.fire.red
        | {{ xp | format_xp }}
</template>

<script lang="coffee">
    import moment from 'moment'
    import avatar from 'vue-avatar'
    import numeral from 'numeral'

    export default
        props:
            avatar: String
            url: String
            username: String
            level: Number
            verified: Boolean
            joined: String
            xp: Number
        components: { avatar }
        filters:
            short_date: (datestamp) ->
                datestamp
            format_xp: (xp) ->
                numeral(xp).format("0,0")
</script>

<style lang="sass" scoped>
    .author
        font-weight: bold
        font-size: 1.2em

    .verified
        display: inline-flex
        vertical-align: middle
        margin-bottom: 5px
        margin-left: 4px

        i
            font-weight: bold
    .level
        margin-bottom: 0.5em

    .bottom.meta
        margin-top: 0.8em
        color: #DB2828

</style>
