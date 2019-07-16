<template lang="pug">
    .ability
        .ui.icon.button(v-bind:class="[color, {active: testing}]" v-touch:tap="onTap")
            i.icon.normal.inverted(v-bind:class="icon")
</template>

<script lang="coffee">
    export default
        props:
            icon: String
            color: String
            access_key: String
            current_access_key: String
        data: ->
            active: false
        computed:
            testing: ->
              return true if @access_key == @current_access_key
              false
        methods:
            onTap: ->
                @active = !@active
                @.$emit('use-ability', @access_key)

</script>
