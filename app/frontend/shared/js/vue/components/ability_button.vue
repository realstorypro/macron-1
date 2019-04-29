<template lang="pug">
    .ability
        .ui.icon.button(v-bind:class="color" @click="onClickButton()")
            i.icon.normal.inverted(v-bind:class="icon")
</template>

<script lang="coffee">
    export default
        props:
            label: String
            icon: String
            color: String
            access_key: String
            disabled: Boolean
        methods:
            onClickButton: ->
                @.$emit('use-ability', @access_key)

</script>

<style lang="sass" scoped>
    .ability
        display: inline-block
        margin-right: 0.5em
</style>
