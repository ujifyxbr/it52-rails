initYandexShare = (element) -> setTimeout (() -> Ya.share2(element)), 0

document.addEventListener 'turbolinks:load', (event) ->
  $('.admin-info i.fas').tooltip()
  $('li.participant a').tooltip()

  $('input#event_started_at').datetimepicker
    locale: 'ru'
    stepping: 15
    showTodayButton: true
    sideBySide: true
    icons:
      time: "fas fa-clock-o"
      date: "fas fa-calendar-alt"
      up: "fas fa-arrow-up"
      down: "fas fa-arrow-down"

  shares = document.querySelectorAll('.ya-share2')
  sharesInitialized = document.querySelectorAll('.ya-share2_inited')

  if shares.length > 0 and sharesInitialized.length is 0
    Array.from(shares).forEach (element) -> initYandexShare(element)
