Turbolinks.setContentWrapper('#wrapper')

hideNoticeAfterDelay = (delay) ->
  hideNotice = ->
    $('#notice').slideUp ->
      $('#notice').remove()

  setTimeout hideNotice, delay

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
    $(target).slideDown ->
      $('textarea', this).focus()
    return false

  $('button[data-dismiss-closest]').on 'click', ->
    target = $(this).data('dismiss-closest')
    $(target).hide()
    return false

  $('#preferences_theme').on 'change', ->
    $('#theme-preview iframe').attr('src', "#{window.location.origin}/?theme=#{this.value}")

  $('.markdown-editor').each ->
    textarea = this.querySelector('textarea')
    preview  = this.querySelector('iframe')

    # Initialize CodeMirror instance
    editor = CodeMirror.fromTextArea textarea,
      mode: 'markdown',
      lineWrapping: true

    # Create a closure that will update the iframe with HTML rendered from the
    # Markdown in the editor
    updatePreview = ->
      doc = preview.contentDocument || preview.contentWindow.document
      html = marked(editor.getValue())
      doc.open()
      doc.write(html)
      doc.close()

      # Keep the iframe the same height as the editor
      editorHeight = $(editor.getWrapperElement()).height()
      $(preview).height(editorHeight)

    # Throttle updates to keep from stressing out the browser's JS engine
    timeoutId = null
    editor.on 'change', ->
      clearTimeout(timeoutId) if timeoutId?
      timeoutId = setTimeout updatePreview, 500

    # Update the preview right away, in case there's already text in the editor
    updatePreview()

  hideNoticeAfterDelay(3000)

$(document).ready onReady

$(document).on 'page:change', onReady
