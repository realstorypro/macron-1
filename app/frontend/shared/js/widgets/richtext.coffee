import Utils from '../core/utils'
import redactor from '../plugins/redactor/redactor'
import fullscreen from '../plugins/redactor/fullscreen'
import widget from '../plugins/redactor/widget'
import video from '../plugins/redactor/video'
import uploadcare from '../plugins/redactor/uploadcare'
import embeddable from '../plugins/redactor/embeddable'
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
      autoparse:false
      autoparsePaste: false
      toolbarFixed: true
      pastePlainText: true
      source: true
      buttons: ['bold', 'italic', 'link', 'ol','ul']
      formatting: ['p']
      plugins: ['fullscreen']
      minHeight: '300px'
      uploadcare:
        buttonIconEnabled: true,
        publicKey: '0a21efa3fc2174ed24f0'

    # init this via a widget vs every time
    $R 'textarea.rich'


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'richtext'

export { Richtext as default }
