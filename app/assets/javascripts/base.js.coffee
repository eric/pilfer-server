$ ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

$(document).on 'click', 'a.js-lineprof-file', ->
  $(this).closest('tbody').toggleClass('view-profile')
  return false
