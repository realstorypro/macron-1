<template lang="pug">
    .editor
        editor-menu-bar(:editor="editor" v-slot="{ commands, isActive }")
            .ui.icon.menu.inverted.black
                .item(:class="{ 'active': isActive.heading({level: 2})}" @click.prevent="commands.heading({level: 2})")
                    i.icon.heading
                .item(:class="{ 'active': isActive.paragraph()}" @click.prevent="commands.paragraph")
                    i.icon.paragraph
                .item(:class="{ 'active': isActive.bold()}" @click.prevent="commands.bold")
                    i.icon.bold
                //.item(:class="{ 'active': isActive.italic()}" @click.prevent="commands.italic")
                //    i.icon.italic
                .item(:class="{ 'active': isActive.ordered_list()}" @click.prevent="commands.ordered_list")
                    i.icon.list.ol
                .item(:class="{ 'active': isActive.horizontal_rule()}" @click.prevent="commands.horizontal_rule")
                    i.icon.minus
                .right.menu
                    .item.reply
                        .ui.button.red
                            i.icon.paper.plane
                            | &nbsp;
                            | REPLY
        editor-content.editor-content(:editor="editor")
</template>

<script lang="coffee">
    import { Editor, EditorContent, EditorMenuBar } from 'tiptap'
    import { Bold, Italic, Heading, BulletList, OrderedList, ListItem, HorizontalRule } from 'tiptap-extensions'

    export default
        components: {EditorContent, EditorMenuBar}
        props:
            commands: Array
        data: ->
            editor: new Editor
                extensions: [new Bold, new Italic, new Heading, new BulletList, new OrderedList, new ListItem, new HorizontalRule ]
        mounted: ->
</script>
