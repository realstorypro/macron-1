(function($R)
{
    $R.add('plugin', 'embeddable', {
        translations: {
            en: {
                "embeddable": "Embed",
                "embeddable-html-code": "Embed Link"
            }
        },
        modals: {
            'embeddable':
                '<form action=""> \
                    <div class="form-item"> \
                        <label for="modal-embeddable-input">## embeddable-html-code ##</label> \
                        <textarea id="modal-embeddable-input" name="embeddable" style="height: 200px;"></textarea> \
                    </div> \
                </form>'
        },
        init: function(app)
        {
            this.app = app;
            this.lang = app.lang;
            this.opts = app.opts;
            this.toolbar = app.toolbar;
            this.component = app.component;
            this.insertion = app.insertion;
            this.inspector = app.inspector;
            this.selection = app.selection;
        },
        // messages
        onmodal: {
            embeddable: {
                opened: function($modal, $form)
                {
                    $form.getField('embeddable').focus();

                    if (this.$currentItem)
                    {
                        var code = decodeURI(this.$currentItem.attr('data-embeddable-code'));
                        $form.getField('embeddable').val(code);
                    }
                },
                insert: function($modal, $form)
                {
                    var data = $form.getData();
                    this._insert(data);
                }
            }
        },
        oncontextbar: function(e, contextbar)
        {
            var data = this.inspector.parse(e.target)
            if (data.isComponentType('embeddable'))
            {
                var node = data.getComponent();
                var buttons = {
                    "edit": {
                        title: this.lang.get('edit'),
                        api: 'plugin.embeddable.open',
                        args: node
                    },
                    "remove": {
                        title: this.lang.get('delete'),
                        api: 'plugin.embeddable.remove',
                        args: node
                    }
                };

                contextbar.set(e, node, buttons, 'bottom');
            }
        },
        onbutton: {
            embeddable: {
                observe: function(button)
                {
                    this._observeButton(button);
                }
            }
        },

        // public
        start: function()
        {
            var obj = {
                title: this.lang.get('embeddable'),
                api: 'plugin.embeddable.open',
                observe: 'embeddable'
            };

            var $button = this.toolbar.addButton('embeddable', obj);
        },
        open: function()
        {
            this.$currentItem = this._getCurrent();

            var options = {
                title: this.lang.get('embeddable'),
                width: '600px',
                name: 'embeddable',
                handle: 'insert',
                commands: {
                    insert: { title: (this.$currentItem) ? this.lang.get('save') : this.lang.get('insert') },
                    cancel: { title: this.lang.get('cancel') }
                }
            };

            this.app.api('module.modal.build', options);
        },
        remove: function(node)
        {
            this.component.remove(node);
        },

        // private
        _getCurrent: function()
        {
            var current = this.selection.getCurrent();
            var data = this.inspector.parse(current);
            if (data.isComponentType('embeddable'))
            {
                return this.component.build(data.getComponent());
            }
        },
        _insert: function(data)
        {
            this.app.api('module.modal.close');

            if (data.embeddable.trim() === '' || (this._isHtmlString(data.embeddable)))
            {
                return;
            }

            var embed_text = '[embed]'+ data.embeddable +'[/embed]';
            var html = document.createTextNode(embed_text);
            var $component = this.component.create('embeddable', html);
            $component.attr('data-embeddable-code', encodeURI(data.embeddable.trim()));
            this.insertion.insertHtml($component);

        },
        _isHtmlString: function(html)
        {
            return !(typeof html === 'string' && !/^\s*<(\w+|!)[^>]*>/.test(html));
        },
        _observeButton: function(button)
        {
            var current = this.selection.getCurrent();
            var data = this.inspector.parse(current);

            if (data.isComponentType('table')) button.disable();
            else button.enable();
        }
    });
})(Redactor);
(function($R)
{
    $R.add('class', 'embeddable.component', {
        mixins: ['dom', 'component'],
        init: function(app, el)
        {
            this.app = app;

            // init
            return (el && el.cmnt !== undefined) ? el : this._init(el);
        },
        getData: function()
        {
            return {
                html: this._getHtml()
            };
        },

        // private
        _init: function(el)
        {
            if (typeof el !== 'undefined')
            {
                var $node = $R.dom(el);
                var $embeddable = $node.closest('div.embed');
                if ($embeddable.length !== 0)
                {
                    this.parse($embeddable);
                }
                else
                {
                    this.parse('<div class="embed">');
                    this.html(el);
                }
            }
            else
            {
                this.parse('<div class="embed">');
            }


            this._initWrapper();
        },
        _getHtml: function()
        {
            var $wrapper = $R.dom('<div>');
            $wrapper.html(this.html());
            $wrapper.find('.redactor-component-caret').remove();

            return $wrapper.html();
        },
        _initWrapper: function()
        {
            this.addClass('redactor-component');
            this.attr({
                'data-redactor-type': 'embeddable',
                'tabindex': '-1',
                'contenteditable': false
            });
        }
    });
})(Redactor);
