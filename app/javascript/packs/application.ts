declare var Ya;

import * as Turbolinks from 'turbolinks'
import Rails from 'rails-ujs'
import { ForeignLinkSwitcher } from './helpers/foreign-link-switcher'

Turbolinks.start()
Rails.start()

document.addEventListener('turbolinks:load', init)

function initYandexShare(element) {
  setTimeout(() => Ya.share2(element), 0);
}

function init(event?: Event | any): void {
  const foreignLinkCheckbox = document.getElementById('has_foreign_link')
  if(!!foreignLinkCheckbox) new ForeignLinkSwitcher()

  const uuid = document.getElementById('uuid').dataset.userId
  if (typeof ga == 'function') {
    ga('set', '&uid', uuid)
    ga('set', 'location', (event as any).data.url)
    ga('send', 'pageview')
  }

  const shares = document.querySelectorAll('.ya-share2')
  const sharesInitialized = document.querySelectorAll('.ya-share2_inited')
  if (shares.length > 0 && sharesInitialized.length == 0) Array.from(shares).forEach(initYandexShare)
}

init({ data: location.href });
