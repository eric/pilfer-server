# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).on 'click', 'a.js-lineprof-file', ->
  $(this).closest('tbody').toggleClass('view-profile')
  return false
