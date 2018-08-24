import Utils from '../core/utils'
import Vent from '../core/vent'

utils = new Utils
vent = new Vent

class Crud
  instance = null

  constructor: ->
    if !instance
      instance = this

      vent.channel().on "widget:crud", (options, href, context) =>

        switch options['action']
          when 'pick' then @pick(options, href, context)
          when 'new' then @form(options, href, context)
          when 'edit' then @form(options, href, context)
          when 'save' then @save(options, href, context)
          when 'delete' then @delete(options, href, context)

    else
      instance

  pick: (options, href, context) ->
    $(context).find('.icon.element').hide()
    $(context).find('.icon.loading').removeClass('hidden')

    $.ajax
      url: href
      type: "GET"
      success: (data, textStatus, jqXHR) =>
        vent.channel().trigger "render",
          action: "refresh"
          html: data

        vent.channel().trigger "widget:drawer",
          action: "close"


  form: (options, href, context) ->
    vent.channel().trigger 'widget:drawer',
      action: 'open'

    $.ajax
      url: href
      type: "GET"
      success: (data, textStatus, jqXHR) =>

        vent.channel().trigger "widget:drawer",
          action: "update"
          html: data

      error: (jqXHR, textStatus, errorThrown) ->
        console.log "call error", jqXHR, textStatus

  save: (options, href, context) ->
    form = $(context).closest('form')
    action = form.attr('action')
    method = form.attr('method')

    # add loading indicator the the button click
    $(context).addClass('loading disabled')

    $.ajax
      url: action
      type: method.toUpperCase()
      data: form.serialize()
      success: (data, textStatus, jqXHR) =>

        # close the drawer & reirect if submission is successful and redirect is passed
        if jqXHR.getResponseHeader('status') is 'success' and jqXHR.getResponseHeader('redirect')
          vent.channel().trigger "widget:drawer",
            action: "close"
          Turbolinks.visit jqXHR.getResponseHeader('redirect')

        # update the page & close the drawer if submission is successful
        else if jqXHR.getResponseHeader('status') is 'success'

          vent.channel().trigger "render",
            action: "refresh"
            html: data

          vent.channel().trigger "widget:drawer",
            action: "close"

        # reload the form if the submission contains an error
        else if jqXHR.getResponseHeader('status') is 'error'
          vent.channel().trigger "widget:drawer",
            action: "update"
            html: data


      error: (jqXHR, textStatus, errorThrown) ->
        console.log "ajax call error", jqXHR, textStatus

  delete: (options, href, context) ->

    $.ajax
      url: href
      type: "POST"
      data: {"_method":"delete"}
      success: (data, textStatus, jqXHR) =>
        options.data = data

      error: (jqXHR, textStatus, errorThrown) ->
        console.log "call error", jqXHR, textStatus

export { Crud as default }

