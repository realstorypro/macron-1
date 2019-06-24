<template lang="pug">
    .reactions.wrap
        template(v-for="score in scores")
            score(v-bind="score")
        .ui.divider
        .ui.button.green.fluid(@click='showMobileModal')
            i.icon.magic
            | Respond
        // modal(name='reaction-modal' width="100%" height="100%" transition="pop-out" :classes="modalClasses")
        //    reactions-wrapper(:user-id="userId", :subject-id="subjectId", :component="component")

</template>

<script lang="coffee">
    import store from '../store/user_store'
    import Utils from '../../core/utils'
    import Score from './reactions/score'
    import ReactionsWrapper from './reactions/reactions_wrapper'

    utils = new Utils

    export default
        props:
            userId: Number
            subjectId: Number
            component: String
        components:
            'score': Score
        computed:
            scores: ->
                store.state.entry
        methods:
            isMobile: ->
                utils.is_mobile()
            showMobileModal: ->
                @.$modal.show('reaction-modal')
</script>
