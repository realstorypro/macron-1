import Utils from '../core/utils'
import 'pickadate-webpack/lib/picker'
import 'pickadate-webpack/lib/picker.date'
import 'daterangepicker'
import moment from 'moment'

utils =  new Utils

class Daterange
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
    utils.log 'setup', 'setup()', 'daterange'

    daterange = $('input.daterange')

    if daterange.length > 0
      input_value = daterange.val().split(' ')

      start_date = input_value[0]
      end_date = input_value[2]

      cb = (start, end) ->
        $('input.daterange span').html start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY')
        Turbolinks.visit "/admin/?start=#{start.format('l')}&end=#{end.format('l')}"


      $('input.daterange').daterangepicker {
        buttonClasses: "ui button",
        applyButtonClasses: "ui button primary",
        cancelClass: "ui button"
        startDate: start_date
        endDate: end_date
        opens: "left"
        ranges:
          'Last 7 Days': [
            moment().subtract(6, 'days')
            moment()
          ]
          'Last 30 Days': [
            moment().subtract(29, 'days')
            moment()
          ]
          'This Month': [
            moment().startOf('month')
            moment().endOf('month')
          ]
          'Last Month': [
            moment().subtract(1, 'month').startOf('month')
            moment().subtract(1, 'month').endOf('month')
          ]
      }, cb



  teardown: () ->
    utils.log 'teardown', 'teardown()', 'datepicker'

export { Daterange as default }
