<template lang="pug">
    textarea(ref="redactor" :name="name" :placeholder="placeholder" :value="value")
</template>

<script lang="coffee">
    import Vue from 'vue/dist/vue.esm'

    export default
        redactor: false
        props:
            value:
                default: ''
                type: String
            placeholder:
                default: null
                type: String
            name:
                default: null
                type: String
            config:
                default: {}
                type: Object
        watch: value: (newValue, oldValue) ->
            if !@redactor.editor.isFocus()
                @redactor.source.setCode newValue
        mounted: ->
            @init()
        beforeDestroy: ->
            @destroy()
        methods:
            init: ->
                me = @
                callbacks = changed: (html) ->
                    me.handleInput html
                    html

                # extend config
                Vue.set @config, 'callbacks', callbacks
                app = $R(@$refs.redactor, @config)

                # set instance
                @redactor = app
                @$parent.redactor = app
            destroy: ->
                # Call destroy on redactor to cleanup event handlers
                $R @$refs.redactor, 'destroy'

                # unset instance for garbage collection
                @redactor = null
                @$parent.redactor = null

            handleInput: (val) ->
                @$emit 'input', val
</script>
