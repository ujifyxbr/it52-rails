html = render partial: 'events/event-item', locals: { event: event }

xml.item(turbo: 'true') do |item|
  item.link event_url(event)
  item.pubDate event.published_at.rfc2822
  item.author event.organizer.to_s
  item.turbo(:content) do |content|
    content.cdata! html
  end
end
