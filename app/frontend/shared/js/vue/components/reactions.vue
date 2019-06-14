<template lang="pug">
    .wrapper
        flipper(:flipKey="flipKey")
            template(v-for="score in scores")
                score(v-bind="score")
            .ui.divider
            .ui.button.green.fluid(@click="trigger")
                i.icon.magic.large
                | Respond

            flipped(flipId="reactions")
                template(v-for="score in scores")
                    score(v-bind="score")
                h1 I am FLIPPED
</template>

<script lang="coffee">
    import axios from 'axios'
    import store from '../store/user_store'
    import { Flipper, Flipped } from "vue-flip-toolkit"
    import Score from './reactions/score'

    import { VTooltip, VPopover, VClosePopover } from 'v-tooltip'

    export default
        props:
            userId: Number
            subjectId: Number
            component: String
        components:
            'score': Score
            'flipped': Flipped
            'flipper': Flipper
        computed:
            scores: ->
                store.state.entry
            flipKey: ->
                @open.toString()
        data: ->
            flipper: null
            open: false
        methods:
            trigger: ->
                @open = !@open
        mounted: ->
            store.dispatch('loadEntry', { id: @subjectId, component: @component } )
</script>
