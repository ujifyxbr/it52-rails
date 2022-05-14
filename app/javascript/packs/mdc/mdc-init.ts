import * as Turbolinks from 'turbolinks';

import { MDCTopAppBar } from '@material/top-app-bar';
import { MDCRipple } from '@material/ripple';
import { MDCList } from '@material/list';
import { MDCDrawer } from '@material/drawer';
import { MDCTabBar } from '@material/tab-bar';
import { MDCMenu } from '@material/menu';
import { MDCSelect } from '@material/select';
import { MDCChipSet } from '@material/chips';

export class MdcInit {
  private static instance: MdcInit;

  private static initPage = location.href;

  topAppBarElement = document.querySelector('.mdc-top-app-bar');

  topAppBar = new MDCTopAppBar(this.topAppBarElement);

  drawer = MDCDrawer.attachTo(document.querySelector('.mdc-drawer'));

  buttons = document.querySelectorAll('.mdc-button, .mdc-fab, .mdc-card__primary-action');

  iconButtons = document.querySelectorAll('.mdc-icon-button');

  lists = document.querySelectorAll('.mdc-list');

  tabBars = document.querySelectorAll('.mdc-tab-bar');

  menus = document.querySelectorAll('.mdc-menu');

  selects = document.querySelectorAll('.mdc-select');

  chips = document.querySelectorAll('.mdc-chip-set');

  static init() {
    if (!MdcInit.instance || MdcInit.initPage !== location.href) {
      MdcInit.initPage = location.href;
      MdcInit.instance = new MdcInit();
    }
    return MdcInit.instance;
  }

  private constructor() {
    this.topAppBar.setScrollTarget(document.getElementById('main-content'));
    this.topAppBar.listen('MDCTopAppBar:nav', () => this.drawer.open = !this.drawer.open);

    // Array.from(this.lists).forEach((list) => MDCList.attachTo(list))
    Array.from(this.buttons).forEach((button: Element) => new MDCRipple(button));
    Array.from(this.iconButtons).forEach((button) => {
      const ripple = new MDCRipple(button);
      ripple.unbounded = true;
    });
    Array.from(this.tabBars).forEach((tabBar: Element) => new MDCTabBar(tabBar));
    Array.from(this.chips).forEach((chip: Element) => new MDCChipSet(chip));
    // Array.from(this.menus).forEach((menu) => new MDCMenu(menu))
    // Array.from(this.selects).forEach((select) => new MDCSelect(select))

    const eventsKindMenu: any = null;
    try {
      const eventsKindMenu = new MDCSelect(document.querySelector('#events-select-menu'));
      eventsKindMenu.listen('MDCSelect:change', (event: CustomEvent) => {
        const menu = document.querySelector('#events-select-menu-list');
        const items = menu.querySelectorAll('.mdc-list-item');
        const selectedItem = items[event.detail.index] as HTMLElement;
        console.log(menu, items, selectedItem);
        Turbolinks.visit(selectedItem.dataset.url);
      });
    } catch (e) { /* Workaround for bugged select menu */ }

    document.addEventListener('turbolinks:request-start', (_: Event) => MdcInit.initPage = null);
  }
}
