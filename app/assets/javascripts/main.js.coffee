onReady = ->
  $('.editor').each ->
    CodeMirror.fromTextArea this,
      mode: 'markdown'

  $('a[data-submit]').on 'click', ->
    link = $(this)
    form = link.closest('form')
    field = link.data('field')
    value = link.data('submit')

    # Set the appropriate field of the form to the specified value
    $("input[name='#{field}']", form).val(value)

    # Submit the form
    form.submit()

    # Prevent this link from going where it would otherwise go
    return false

$(document).ready onReady

$(document).on 'page:change', onReady
