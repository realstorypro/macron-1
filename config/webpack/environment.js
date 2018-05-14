const { environment } = require('@rails/webpacker')

const coffee =  require('./loaders/coffee')
const vue =  require('./loaders/vue')
const webpack = require('webpack')

environment.plugins.append(
    'Provide',
    new webpack.ProvidePlugin({
        jQuery: 'jquery',
        $: 'jquery',
        jquery: 'jquery'
    })
)

environment.loaders.append('vue', vue)
environment.loaders.append('coffee', coffee)
module.exports = environment
