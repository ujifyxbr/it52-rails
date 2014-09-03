$ ->
  $('.admin-info i.fa').tooltip()
  $('li.participant a').tooltip()

  if $('#uuid').length > 0
    uid = document.getElementById('uuid').dataset.userId
    ga('set', '&uid', uid)

