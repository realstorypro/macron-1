import Utils from '../core/utils'
import redactor from '../plugins/redactor/redactor'
import fullscreen from '../plugins/redactor/fullscreen'

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
      toolbarFixed: false
      autoparseVideo: false
      buttons: ['format', 'bold', 'italic', 'link', 'ol','ul','line']
      formatting: ['p', 'blockquote', 'h2']
      plugins: ['fullscreen']
      minHeight: '300px'

    $R 'textarea.rich'


  teardown: () ->
    utils.log 'teardown', 'teardown()', 'richtext'

export { Richtext as default }
