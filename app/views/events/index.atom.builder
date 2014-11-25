atom_feed language: 'ru-RU', root_url: events_url do |feed|
  feed.title t :app_name
  feed.subtitle t :app_description
  feed.icon asset_url('logo-it52-16x16.png')
  feed.logo asset_url('logo-it52.png')
  feed.updated @rss_events.last.updated_at
  feed.rights  "© 2005 — #{Date.today.year}, #{Figaro.env.mailing_host}"

  feed.author do |author|
    author.name t :app_name
    author.uri root_url
  end

  @rss_events.each do |event|
    feed.entry(event) do |entry|
      entry.title event.title
      entry.summary event.summary
      entry.content event.full_description.html_safe, type: "html"

      entry.author do |author|
        author.name event.organizer.to_s
        author.uri user_url(event.organizer.slug)
      end
    end
  end
end
