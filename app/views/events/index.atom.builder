atom_feed language: 'ru-RU',
          root_url: events_url,
          'xmlns:content' => 'http://purl.org/rss/1.0/modules/content/',
          'xmlns:webfeeds' => 'http://webfeeds.org/rss/1.0' do |feed|
  feed.title t :app_name
  feed.subtitle t :app_description
  feed.icon asset_url('it52-logo-32x32.png')
  feed.logo asset_url('it52-logo-192x192.png')
  feed.updated (@rss_events.last || Event.published.order(published_at: :asc).last).updated_at
  feed.category term: 'tech'
  feed.category term: 'IT'
  feed.category term: 'programming'
  feed.rights "© 2014 — #{Date.today.year}, #{ENV.fetch('mailing_host') {'mailing_host'}}"
  feed.webfeeds(:cover, image: asset_url('it52_logo_fb@2x.png'))
  feed.webfeeds(:icon, asset_url('it52_logo_white_clean.svg'))
  feed.webfeeds(:analytics, id: 'UA-54446007-1', engine: 'GoogleAnalytics')

  feed.author do |author|
    author.name t :app_name
    author.uri root_url
    author.email 'events@it52.info'
  end

  @rss_events.each do |event|
    feed.entry(event) do |entry|
      entry.title event.title

      entry.summary type: "xhtml" do |xhtml|
        xhtml.strong l(event.started_at)
        xhtml.em event.place
      end

      entry.author do |author|
        author.name event.organizer.to_s
        author.uri user_url(event.organizer)
      end

      entry.content ("<div>#{image_tag(event.title_image.fb_1200.url)}</div>" + event.rendered_description).html_safe, type: 'html'
    end
  end
end
