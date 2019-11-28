import Utils from '../core/utils'
import Vent from '../core/vent'

utils = new Utils
vent = new Vent

class Consent
  instance = null

  constructor: ->
    if !instance
      instance = this
    else
      instance

  setup: () ->
    utils.log 'setup', 'setup()', 'consent'
    console.log 'consent ready'

  teardown: () ->
    utils.log 'teardown', 'teardown()', 'consent'

export { Consent as default }

