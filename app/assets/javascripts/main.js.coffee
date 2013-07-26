onReady = ->
  $('.editor').each ->
    CodeMirror.fromTextArea this,
      mode: 'markdown'
      lineWrapping: true

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

  $('button[data-reveal]').on 'click', ->
    target = $(this).data('reveal')
    $(target).slideDown()
    return false

  $('button[data-dismiss-closest]').on 'click', ->
    target = $(this).data('dismiss-closest')
    $(target).hide()
    return false

  $('#preferences_theme').on 'change', ->
    $('#theme-preview iframe').attr('src', "#{window.location.origin}/?theme=#{this.value}")

$(document).ready onReady

$(document).on 'page:change', onReady
