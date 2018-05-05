import {} from 'jquery-ujs'
import uploadcare from 'uploadcare-widget'
import Turbolinks from 'turbolinks'
import semantic_js from '../semantic/dist/semantic.min'

import Chartkick from "chartkick"
import Chart from "chart.js"

Turbolinks.start()

window.Chartkick = Chartkick
Chartkick.addAdapter(Chart)

import Settings from '../shared/js/core/settings'
import App from '../shared/js/admin_app'
import Utils from '../shared/js/core/utils'

app = new App
settings = new Settings
utils = new Utils

settings.set version: 'Version 2 ' # set the application version
settings.set debug: true # show the debug messages
settings.set design: false # design mode disables the uploadcare widget

utils.draw 'blank_header'
utils.log 'header', '****'
utils.log 'header', 'Initializing Genesis Admin'
utils.log 'header', "#{settings.get('version')}"
utils.log 'header', "********"
utils.draw 'blank_header'
utils.log 'setting', "Debug: #{settings.get('debug')}"
utils.log 'setting', "Design: #{settings.get('design')}"

# app.initialize()

# toggle uploadcare based on settings
if settings.get('design')
  window.UPLOADCARE_LIVE = false
else
  window.UPLOADCARE_LIVE = true

# take the app out of the loading state
$ ->
  buttons = document.getElementsByClassName('button')
  for button in buttons
    button.classList.remove('loading')
    button.classList.remove('disabled')

document.addEventListener 'turbolinks:load', ->
  utils.log 'status', 'app.reload()'
  app.reload()
