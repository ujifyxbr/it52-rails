$ ->
  $('.admin-info i.fa').tooltip()
  $('li.participant a').tooltip()

  uid = document.getElementById('uuid').dataset.userId
  ga('set', '&uid', uid)
