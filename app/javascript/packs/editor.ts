// Run this example by adding <%= javascript_pack_tag 'hello_typescript' %> to the head of your layout file,
// like app/views/layouts/application.html.erb.

import * as SimpleMDE from 'simplemde'
import flatpickr from 'flatpickr'
import { Russian } from 'flatpickr/dist/l10n/ru'

function hasEditor(): boolean {
  return document.querySelectorAll('.editor-toolbar').length > 0
}

function init(event?: Event): void {
  flatpickr('#event_started_at', {
    enableTime: true,
    minuteIncrement: 15,
    time_24hr: true,
    defaultHour: 19,
    dateFormat: "d.m.Y H:i",
    minDate: 'today',
    locale: Russian
  })


  const simplemdeEl = document.querySelectorAll('#event_description, #user_bio')[0]
  if (!!simplemdeEl && !hasEditor()) {
    const simplemde = new SimpleMDE({
      element: simplemdeEl,
      indentWithTabs: false,
      promptURLs: true,
      spellChecker: false,
      hideIcons: ['image']
    })
  }
}

document.addEventListener('turbolinks:load', init)
init()
