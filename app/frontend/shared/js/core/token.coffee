import axios from 'axios'
import Utils from './utils'

utils =  new Utils

class Token
  instance = null

  # implementing singleton pattern
  constructor : () ->
    if !instance then instance = this
    return instance

  reinit: () ->
    @teardown()
    @setup()

  setup: () ->
    utils.log 'setup', 'setup()', 'token'

    token = document.getElementsByName('csrf-token')[0].content
    axios.defaults.headers.common['X-CSRF-Token'] = token
    axios.defaults.headers.common['Accept'] = 'application/json'

export { Token as default}