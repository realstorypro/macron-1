<template lang="pug">
    .ability
        .ui.icon.button(v-bind:class="[color, {active: active}]" v-touch:tap="onTap")
            i.icon.normal.inverted(v-bind:class="icon")
</template>

<script lang="coffee">
    export default
        props:
            icon: String
            color: String
            castTime: Number
            access_key: String
        data: ->
            active: false
        methods:
            onTap: ->
                @active = !@active
                @.$emit('use-ability', @access_key)

            # Factor this intot the main thing later
            # onMouseOut: ->
            #     @.$emit('use-ability', null)

</script>
