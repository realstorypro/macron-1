<template lang="pug">
    .ability
        .ui.icon.button(:class="[button_color, {active: active_class}]" v-touch:tap="onTap")
            i.icon.normal.inverted(:class="icon")
</template>

<script lang="coffee">
    export default
        props:
            icon: String
            color: String
            access_key: String
            current_access_key: String
            energy: Number
            current_energy: Number
        data: ->
            active: false
        computed:
            button_color: ->
              return 'grey disabled' if @energy > @current_energy
              @color
            active_class: ->
              return true if @access_key == @current_access_key
              false
        methods:
            onTap: ->
                @active = !@active
                @.$emit('use-ability', @access_key)
        mounted: ->
          console.log 'energy', @energy, @current_energy

</script>
