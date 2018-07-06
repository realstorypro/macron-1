import Utils from '../core/utils'
import redactor from '../plugins/redactor/redactor'
import fullscreen from '../plugins/redactor/fullscreen'
import widget from '../plugins/redactor/widget'
import video from '../plugins/redactor/video'
import uploadcare from '../plugins/redactor/uploadcare'
import $ from 'jquery'

utils =  new Utils

class Richtext
  instance = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'richtext'

    $R.options =
      toolbarFixed: true
      autoparseVideo: false
      source: true
      buttons: ['html','format', 'bold', 'italic', 'link', 'ol','ul','line']
      formatting: ['p', 'blockquote', 'h2']
      plugins: ['fullscreen', 'uploadcare', 'video', 'widget']
      minHeight: '300px'
      uploadcare:
        buttonIconEnabled: true,
        publicKey: 'f84e9ab7fe974381ac89'

    $R 'textarea.rich'


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'richtext'

export { Richtext as default }
