declare let Ya;
declare let ymaps;
declare let ym;

export class YandexInit {
  private static instance: YandexInit;

  private static initPage = location.href;

  private static referer: string|null = null;

  private shares = document.querySelectorAll('.ya-share2');

  private map = document.getElementById('event-map');

  static init() {
    if (!YandexInit.instance || YandexInit.initPage !== location.href) {
      YandexInit.initPage = location.href;
      YandexInit.instance = new YandexInit();
      document.addEventListener('turbolinks:request-start', (_: Event) => {
        YandexInit.initPage = null;
      });
      document.addEventListener('turbolinks:before-visit', (_: Event) => {
        YandexInit.referer = location.href;
      });
    }
    return YandexInit.instance;
  }

  private get hasShares(): boolean {
    return this.shares.length > 0;
  }

  private get hasMap(): boolean {
    return !!this.map;
  }

  private constructor() {
    if (this.hasShares) this.initShares();
    if (this.hasMap) this.initMap();
  }

  private initMetrika(): void {
    ym(50290294, 'hit', location.href, {
      title: document.title,
      referer: YandexInit.referer,
    });
  }

  private initShares(): void {
    Array.from(this.shares).forEach(this.initYandexShare);
  }

  private initYandexShare(element): void {
    setTimeout(() => Ya.share2(element), 0);
  }

  private initMap(): void {
    ymaps.ready(() => {
      const geo = [this.map.dataset.lat, this.map.dataset.long];
      const options = {
        center: geo,
        zoom: 16,
        controls: ['smallMapDefaultSet'],
      };
      const eventMap = new ymaps.Map('event-map', options);
      eventMap.geoObjects.add(new ymaps.Placemark(
        geo,
        { balloonContentHeader: this.map.dataset.title },
        { preset: 'islands#blackGovernmentIcon' },
      ));
    });
  }
}
