// Run this example by adding <%= javascript_pack_tag 'hello_typescript' %> to the head of your layout file,
// like app/views/layouts/application.html.erb.

import * as SimpleMDE from 'simplemde'

document.addEventListener('turbolinks:load', init)

function hasEditor(): boolean {
  return document.querySelectorAll('.editor-toolbar').length > 0
}

function init(event?: Event | any): void {
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

init({ data: location.href });
