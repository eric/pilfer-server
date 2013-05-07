$ ->
  timeToggle = $('#time-toggle button').on 'click', (e) ->
    button = $(e.target)
    button.parent()
      .find('.active')
      .removeClass('active')
      .each (i, deselected) ->
        $('body').removeClass $(deselected).attr('id')

    button.addClass('active')
    selectedTime = button.attr('id')
    $('body').addClass selectedTime
    document.cookie = "time-toggle=#{selectedTime}"

  cookieValue  = document.cookie.match(/time-toggle=([\w-]+)/)
  selectedTime = if cookieValue then cookieValue[1] else 'wall-time'
  $("##{selectedTime}").trigger 'click'
