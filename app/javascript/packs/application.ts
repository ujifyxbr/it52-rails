// Run this example by adding <%= javascript_pack_tag 'hello_typescript' %> to the head of your layout file,
// like app/views/layouts/application.html.erb.

import * as Turbolinks from 'turbolinks'

import { ForeignLinkSwitcher } from './helpers/foreign-link-switcher'

Turbolinks.start()

document.addEventListener('turbolinks:load', init)

function init(event?: Event | any): void {
  const foreignLinkCheckbox = document.getElementById('has_foreign_link')
  if(!!foreignLinkCheckbox) new ForeignLinkSwitcher()

  let uuid = document.getElementById('uuid').dataset.userId
  if (typeof ga == 'function') {
    ga('set', '&uid', uuid)
    ga('set', 'location', (event as any).data.url)
    ga('send', 'pageview')
  }
}

init({ data: location.href });
