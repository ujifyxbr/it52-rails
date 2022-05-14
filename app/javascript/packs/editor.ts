import * as SimpleMDE from 'simplemde';
import flatpickr from 'flatpickr';
import { Russian } from 'flatpickr/dist/l10n/ru';

function hasEditor(): boolean {
  return document.querySelectorAll('.editor-toolbar').length > 0;
}

function init(event?: Event): void {
  flatpickr('#event_started_at', {
    enableTime: true,
    minuteIncrement: 15,
    time_24hr: true,
    defaultHour: 19,
    dateFormat: 'd.m.Y H:i',
    minDate: 'today',
    locale: Russian,
  });

  const simplemdeElements = document.querySelectorAll('.mde-textarea');
  if (simplemdeElements.length > 0 && !hasEditor()) {
    simplemdeElements.forEach((el) => {
      new SimpleMDE({
        element: el,
        indentWithTabs: false,
        promptURLs: true,
        spellChecker: false,
        hideIcons: ['image'],
      });
    });
  }
}

document.addEventListener('turbolinks:load', init);
init();
