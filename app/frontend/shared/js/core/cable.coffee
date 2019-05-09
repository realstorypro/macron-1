import cable from 'actioncable'

class Cable
  instance = null

  # implementing singleton pattern
  constructor : () ->
    if !instance
      instance = this
      @cable = cable.createConsumer()

    instance

export { Cable as default}
