# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.fancybox').fancybox
  width: 800,
  height: 'auto',
  autoSize: false

$('.fancybox.add-translation').fancybox
  beforeLoad: () ->
    selection = window.getSelection()
    selection_in_story = this.element.parents('.paragraph').find(selection.anchorNode)
    if selection_in_story.length != 0
      this.href += '?text=' + encodeURIComponent(selection.toString())
