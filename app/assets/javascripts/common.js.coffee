$ ->
  $('.admin-info i.fa').tooltip()
  $('li.participant a').tooltip()


  $('#sign-up-form [href="#sign-up"]').tab('show') if window.location.pathname == "/user_registration/" && window.location.hash == "#sign-up"
