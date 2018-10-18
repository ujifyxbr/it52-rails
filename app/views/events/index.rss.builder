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

    Rails.cache.fetch(@rss_events.object.cache_key) do
      @rss_events.each do |event|
        html = render partial: 'event-item', locals: { event: event }
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


# <rss
#     xmlns:yandex="http://news.yandex.ru"
#     xmlns:media="http://search.yahoo.com/mrss/"
#     xmlns:turbo="http://turbo.yandex.ru"
#     version="2.0">
#     ...
# </rss>

# atom_feed language: 'ru-RU', root_url: events_url do |feed|
#   feed.title t :app_name
#   feed.subtitle t :app_description
#   feed.icon asset_url('logo-it52-16x16.png')
#   feed.logo asset_url('logo-it52.png')
#   feed.updated (@rss_events.last || Event.published.order(published_at: :asc).last).updated_at
#   feed.category "Tech"
#   feed.category "IT"
#   feed.category "Geek"
#   feed.rights  "© 2014 — #{Date.today.year}, #{Figaro.env.mailing_host}"

#   feed.author do |author|
#     author.name t :app_name
#     author.uri root_url
#   end

#   @rss_events.each do |event|
#     feed.entry(event) do |entry|
#       entry.title event.title
#       entry.content event.full_description.html_safe, type: "html"

#       entry.summary type: "xhtml" do |xhtml|
#         xhtml.strong l(event.started_at)
#         xhtml.em event.place
#       end

#       entry.author do |author|
#         author.name event.organizer.to_s
#         author.uri user_url(event.organizer.slug)
#       end
#     end
#   end
# end
