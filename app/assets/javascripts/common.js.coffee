$ ->
  $('.admin-info i.fa').tooltip()
  $('li.participant a').tooltip()

  if $('#uuid').length > 0
    uid = document.getElementById('uuid').dataset.userId
    ga('set', '&uid', uid)

  $('input#event_started_at').datetimepicker
    language: 'ru'
    minuteStepping: 15
    showToday: true
    sideBySide: true
    icons:
      time: "fa fa-clock-o"
      date: "fa fa-calendar"
      up: "fa fa-arrow-up"
      down: "fa fa-arrow-down"

  Turbolinks.enableProgressBar()
