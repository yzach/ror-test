# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

RegExp.quote = (str) ->
  (str+'').replace(/([.?*+^$[\]\\(){}|-])/g, "\\$1")

$ ->
  $translationEditor = $('.translation_editor')

  setComplaintStatus = (complaint, status) ->
    complaint.find('.status')[0].value = status

  acceptComplaint = (complaint) ->
    setComplaintStatus complaint, 'accepted'

  rejectComplaint = (complaint) ->
    setComplaintStatus complaint, 'rejected'

  $('button.accept').click (event) ->
    event.preventDefault()
    event.stopPropagation()
    complaint = $(this).parents('.complaint')
    $(@).addClass('btn-success')
    $('.reject', complaint).removeClass('btn-danger')
    acceptComplaint(complaint)
    false

  $('button.reject').click (event) ->
    event.preventDefault()
    event.stopPropagation()
    complaint = $(this).parents('.complaint')
    $(@).addClass('btn-danger')
    $('.accept', complaint).removeClass('btn-success')
    rejectComplaint(complaint)
    false

  $('form.edit_story_translation').submit (event) ->
    document.getElementById('story_translation_text').value = $translationEditor.text()

  class Highlighter
    constructor: (@editor, @complaints) ->
      @text = editor.html()

    highlight: () ->
      text = @text
      insert = @insert
      tags = []
      for complaint in @complaints.get()
        complaint_text = complaint.getAttribute('data-text')

        for line in complaint_text.split(/\n\r?/)
          index = text.indexOf line
          continue if index <= -1

          tags.push
            index: index
            tag: "<mark data-complaint-id=#{complaint.id}>"
          tags.push
            index: index + line.length
            tag: "</mark>"

      tags.sort (a, b) -> a.index < b.index
        .map (complaint) ->
          text = insert text, complaint.tag, complaint.index
      @editor.html text

    insert: (text, tag, position) ->
      text.slice(0, position) + tag + text.slice(position)

    removeWhiteSpace: (text) ->
      text.replace(/\s+/g, ' ')

  highlighter = new Highlighter($translationEditor, $('.complaint'))
  highlighter.highlight()

  $('mark', $translationEditor).hover () ->
    $('#' + $(@).data('complaint-id')).toggleClass 'selected'

  $('.complaint').hover () ->
    $("[data-complaint-id=#{@.id}]", $translationEditor).toggleClass 'selected'
