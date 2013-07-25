onReady = ->
  $('a[data-confirm=*]').on 'click', ->
    confirmationMessage = $(this).data('confirm')
    if !confirm(confirmationMessage)
      return false

$(document).ready ->
  onReady()

$(document).on 'page:change', onReady
