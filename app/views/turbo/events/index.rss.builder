xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0',
        'xmlns:yandex' => 'http://news.yandex.ru',
        'xmlns:media' => 'http://search.yahoo.com/mrss/',
        'xmlns:turbo' => 'http://turbo.yandex.ru' do
  xml.channel do
    xml.title ['it52', t(:app_name)].join(' | ')
    xml.link root_url
    xml.description t :app_description
    xml.language 'ru'
    xml.turbo(:analytics, id: '50290294', type: 'Yandex')
    xml.turbo(:analytics, id: 'UA-54446007-1', type: 'Google')

    Rails.cache.fetch(@events.object.cache_key) do
      @events.each do |event|
        html = render partial: 'events/event-item', locals: { event: event }

        xml.item(turbo: 'true') do |item|
          item.link event_url(event)
          item.pubDate event.published_at.rfc2822
          item.author event.organizer.to_s
          item.turbo(:content) do |content|
            content.cdata! html
          end
        end
      end
    end
  end
end
