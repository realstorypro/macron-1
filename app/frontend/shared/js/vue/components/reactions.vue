<template lang="pug">
    .wrap
        template(v-for="score in scores")
            score(v-bind="score")
        .ui.divider
        v-popover(class="actioner tooltip" placement="left")
            .ui.button.green.large.fluid
                i.icon.magic
                | Respond
            template(slot="popover")
                h1 hello world guys

</template>

<script lang="coffee">
    import axios from 'axios'
    import store from '../store/user_store'
    import Score from './reactions/score'

    import { VTooltip, VPopover, VClosePopover } from 'v-tooltip'

    export default
        props:
            userId: Number
            subjectId: Number
            component: String
        components:
            'score': Score
            'v-popover': VPopover
        directives:
            'tooltip': VTooltip
            'close-popover': VClosePopover
        computed:
            scores: ->
                store.state.entry
        data: -> {}
        mounted: ->
            store.dispatch('loadEntry', { id: @subjectId, component: @component } )
</script>
