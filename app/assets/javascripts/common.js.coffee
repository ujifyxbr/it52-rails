initYandexShare = (element) -> setTimeout (() -> Ya.share2(element)), 0

displayResults = (response) ->
  console.log(response)

# queryReports = () ->
#   gapi.client.request({
#     path: '/v4/reports:batchGet'
#     root: 'https://analyticsreporting.googleapis.com/'
#     method: 'POST'
#     body:
#       reportRequests: [
#         {
#           viewId: VIEW_ID,
#           dateRanges: [
#             {
#               startDate: '7daysAgo',
#               endDate: 'today'
#             }
#           ],
#           metrics: [{ expression: 'ga:sessions' }]
#         }
#       ]
#   }).then(displayResults, console.error.bind(console));

start = () ->
  gapi.client.init({
    apiKey: 'WemgJsdSj21MbgDpDPotyLuz',
    # // Your API key will be automatically added to the Discovery Document URLs.
    # discoveryDocs: ['https://people.googleapis.com/$discovery/rest'],
    # // clientId and scope are optional if auth is not required.
    clientId: '906201887339-m7bmjtsk94pin8av2shoasbkasshp4er.apps.googleusercontent.com',
    scope: 'https://www.googleapis.com/auth/analytics.readonly'
  }).then(() ->
    # // 3. Initialize and make the API request.
    gapi.client.request({
      path: '/v4/reports:batchGet',
      root: 'https://analyticsreporting.googleapis.com/',
      method: 'POST',
      body: {
        reportRequests: [
          {
            viewId: VIEW_ID,
            dateRanges: [
              {
                startDate: '7daysAgo',
                endDate: 'today'
              }
            ],
            metrics: [
              {
                expression: 'ga:sessions'
              }
            ]
          }
        ]
      }
    })
  ).then((response) ->
    console.log(response);
  , (reason) ->
    console.log('Error:', reason);
  );

document.addEventListener 'turbolinks:load', (event) ->
  if $('input#has_foreign_link').is(':checked')
    $('div#event_foreign_link_box').removeClass("hidden")
  $('input#has_foreign_link').on 'change', ->
    $('div#event_foreign_link_box').toggleClass('hidden')
    if !$(this).is(":checked")
      $('input#event_foreign_link').val('').attr('disable', true)
    else
      $('input#even_foreign_link').attr('disable', false)

  gapi.load('client', start);

  simplemdeId = document.querySelectorAll('.edit_event')[0]?.id
  simplemdeId ||= document.getElementById('new_event')?.id
  simplemdeId ||= document.getElementById('user_bio')?.id
  hasEditor = document.querySelectorAll('.editor-toolbar').length > 0
  if simplemdeId? and not hasEditor
    delete window.simpleMDE
    editorElement = document.getElementById("event_description")
    editorElement ||= document.getElementById("user_bio")
    window.simpleMDE = new SimpleMDE
      element: editorElement
      indentWithTabs: false
      promptURLs: true
      spellChecker: false
      autosave:
        enabled: true
        deplay: 3
        uniqueId: simplemdeId
      hideIcons: ['image']

  $('.admin-info i.fas').tooltip()
  $('li.participant a').tooltip()

  if $('#uuid').length > 0
    uid = document.getElementById('uuid').dataset.userId
    ga?('set', '&uid', uid)

  if typeof ga is 'function'
    ga('set', 'location', event.data.url)
    ga('send', 'pageview')

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



VIEW_ID = "90699875"
