(function($R)
{
    $R.add('plugin', 'embeddable', {
        modals: {
            'embeddable': '<form action="">'
                + '<div class="form-item">'
                + '<label>## embeddable-label ##</label>'
                + '<textarea name="text" style="height: 200px;"></textarea>'
                + '</div>'
                + '</form>'
        },
        translations: {
            en: {
                "embeddable": "embed",
                "embeddable-label": "Please enter the URL to embed"
            }
        },
        init: function(app)
        {
            // define app
            this.app = app;

            // define services
            this.lang = app.lang;
            this.toolbar = app.toolbar;
            this.insertion = app.insertion;
        },

        // messages
        onmodal: {
            embeddable: {
                opened: function($modal, $form)
                {
                    $form.getField('text').focus();
                },
                insert: function($modal, $form)
                {
                    var data = $form.getData();
                    this._insert(data);
                }
            }
        },

        // public
        start: function()
        {
            // create the button data
            var buttonData = {
                title: this.lang.get('embeddable'),
                api: 'plugin.embeddable.open'
            };

            // create the button
            var $button = this.toolbar.addButton('embeddable', buttonData);
        },
        open: function()
        {
            var options = {
                title: this.lang.get('embeddable'),
                width: '600px',
                name: 'embeddable',
                handle: 'insert',
                commands: {
                    insert: { title: this.lang.get('insert') },
                    cancel: { title: this.lang.get('cancel') }
                }
            };

            this.app.api('module.modal.build', options);
        },

        // private
        _insert: function(data)
        {
            this.app.api('module.modal.close');

            if (data.text.trim() === '') return;

            this.insertion.insertText('[embed]'+data.text+'[/embed]');
        }
    });
})(Redactor);