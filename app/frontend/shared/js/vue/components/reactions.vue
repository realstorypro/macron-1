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
                .mobile.scores
                    template(v-for="score in scores")
                        score(v-bind="score")
                .ui.divider
                .ui.grid
                    .column.sixteen.wide
                        progress-bar(:label="'Level ' + level" color="purple" :percent="70" :active-cast="false")
                        progress-bar(label="Energy" color="orange" :percent="energyPercent" :active-cast="false")
                        progress-bar(label="Casting" color="blue" :percent="castPercent" :active-cast="activeCast")
                .ui.divider
                .ui.grid
                    .column.sixteen.wide
                        template(v-for="spell in spells")
                            ability-button(@use-ability="useAbility" @casting="doCast" v-bind="spell" v-bind:active-cast="activeCast")
                .ui.grid
                    .column.sixteen.wide
                        template(v-if="selectedAbility")
                            ability-details(v-bind="selectedAbility")
                        template(v-else="")
                            select-ability
        template(v-else)
            v-popover(class="actioner tooltip" placement="left")
                .ui.button.green.fluid
                    i.icon.magic
                    | Respond
                template(slot="popover")
                    h1 desktop popover

</template>

<script lang="coffee">
    import axios from 'axios'
    import VModal from 'vue-js-modal'
    import store from '../store/user_store'
    import Utils from '../../core/utils'

    import Score from './reactions/score'
    import ProgressBar from './progress_bar'
    import AbilityButton from './ability_button'
    import AbilityDetails from './ability_details'
    import SelectAbility from './select_ability'

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
            'progress-bar': ProgressBar
            'ability-button': AbilityButton
            'ability-details': AbilityDetails
            'select-ability': SelectAbility
        directives:
            'tooltip': VTooltip
            'close-popover': VClosePopover
        computed:
            scores: ->
                store.state.entry
            level: ->
                store.state.user.level
            spells: ->
                store.state.user.spells
            energyPercent: ->
                store.state.user.energy / store.state.user.max_energy * 100
            selectedAbility: ->
                return false unless @current_access_key
                store.state.user.spells.filter((item) =>
                    item.access_key == @current_access_key
                )
        methods:
            isMobile: ->
                utils.is_mobile()
            showMobileModal: ->
                @$modal.show('hello-world')
            useAbility: (event) ->
                @current_access_key = event
            doCast: (percent) ->
                @castPercent = percent

                if @castPercent == 100
                    store.dispatch('castSpell',
                        id: @userId
                        spell: @current_access_key,
                        subject_id: @subjectId,
                        component: @component
                    )

                    ability = store.state.user.spells.filter((item) =>
                        item.access_key == @current_access_key
                    )
                    store.dispatch('reduceEnergy', ability[0].energy)

                    @activeCast = true
        data: ->
            current_access_key: null
            castPercent: 0
            activeCast: false
        mounted: ->
            store.dispatch('loadUser', @userId)
            store.dispatch('loadEntry', { id: @subjectId, component: @component } )
            
            cable.subscriptions.create { channel: 'EntryChannel', entry_id: @subjectId},
                received: (_data) =>
                    store.dispatch('loadEntry', { id: @subjectId, component: @component } )

            cable.subscriptions.create { channel: 'UserChannel', user_id: @userId},
                received: (_data) =>
                    store.dispatch('loadUser', @userId)
                    @activeCast = false
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
</style>
