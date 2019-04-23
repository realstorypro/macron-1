const { environment } = require('@rails/webpacker')

const pug =  require('./loaders/pug')
const coffee =  require('./loaders/coffee')
const vue =  require('./loaders/vue')
const webpack = require('webpack')

environment.plugins.append(
    'Provide',
    new webpack.ProvidePlugin({
        'window.jQuery': 'jquery',
        'window.$': 'jquery',
        jQuery: 'jquery',
        $: 'jquery',
        jquery: 'jquery'
    })
)

environment.loaders.append('pug', pug)
environment.loaders.append('coffee', coffee)
environment.loaders.append('vue', vue)
module.exports = environment
