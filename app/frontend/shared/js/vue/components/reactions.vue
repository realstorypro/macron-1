<template lang="pug">
    .reactions.wrap
        template(v-for="score in scores")
            score(v-bind="score")
        .ui.divider
        template(v-if="isMobile()")
            .ui.button.green.fluid(@click='showMobileModal')
                i.icon.magic
                | Respond
            modal(name='hello-world' width="100%" height="100%" transition="pop-out" classes="mobile-reactions")
                reactions-wrapper(:user-id="userId", :subject-id="subjectId", :component="component")
        template(v-else)
            v-popover(class="actioner tooltip" placement="left")
                .ui.button.green.fluid
                    i.icon.magic
                    | Respond
                template(slot="popover")
                    .reactions.desktop
                        reactions-wrapper(:user-id="userId", :subject-id="subjectId", :component="component")

</template>

<script lang="coffee">
    import VModal from 'vue-js-modal'
    import store from '../store/user_store'
    import Utils from '../../core/utils'
    import Score from './reactions/score'
    import ReactionsWrapper from './reactions/reactions_wrapper'

    import { VTooltip, VPopover, VClosePopover } from 'v-tooltip'

    utils = new Utils

    export default
        props:
            userId: Number
            subjectId: Number
            component: String
        components:
            'score': Score
            'v-popover': VPopover
            'reactions-wrapper': ReactionsWrapper
        directives:
            'tooltip': VTooltip
            'close-popover': VClosePopover
        computed:
            scores: ->
                store.state.entry
        methods:
            isMobile: ->
                utils.is_mobile()
            showMobileModal: ->
                @$modal.show('hello-world')
</script>

<style lang="sass">
    .reactions.wrap
        .mobile.wrapper
            width: 100%
            padding: 1em
            background: #fff

        .v--modal-overlay
            z-index: 1005 !important
            background: #fff

        .v--modal
            border-radius: 0 !important

        .mobile-reactions
            top: 0 !important
            padding: 1em

        .mobile.scores
            text-align: center

    // we are placing this outside of the wrap, because popover
    // is outside of the wrap.
    .reactions.desktop
        width: 500px
        padding: 1em
</style>
