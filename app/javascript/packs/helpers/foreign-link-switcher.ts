export class ForeignLinkSwitcher {
  foreignLinkCheckbox   = document.getElementById('has_foreign_link')       as HTMLInputElement
  foreignLinkSwitchedEl = document.getElementById('event_foreign_link_box') as HTMLDivElement
  foreignLinkInput      = document.getElementById('event_foreign_link')     as HTMLInputElement

  get isChecked(): boolean {
    return this.foreignLinkCheckbox.checked
  }

  constructor() {
    if (this.isChecked) this.foreignLinkSwitchedEl.classList.remove('hidden')
    this.bindEvents()
  }

  bindEvents() {
    this.foreignLinkCheckbox.addEventListener('change', (_event) => {
      this.foreignLinkSwitchedEl.classList.toggle('hidden')
      if (!this.isChecked) {
        this.foreignLinkInput.value = ''
        this.foreignLinkInput.setAttribute('disable', 'disabled')
      } else {
        this.foreignLinkInput.removeAttribute('disabled');
      }
    })
  }
}
