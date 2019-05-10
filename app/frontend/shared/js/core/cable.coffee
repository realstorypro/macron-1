import actioncable from 'actioncable'

class Cable
  instance = null
  consumer = null

  # implementing singleton pattern
  constructor : () ->
    if !instance then instance = this
    instance

  consumer: () ->
    if !consumer then consumer = actioncable.createConsumer()
    consumer


export { Cable as default}
