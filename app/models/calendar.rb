# frozen_string_literal: true

class Calendar
  DOMAIN = ENV.fetch('mailing_host') { 'mailing_host' }
  DEFAULTS = {
    prodid: "-//#{DOMAIN}//IT events calendar//RU",
    url: Rails.application.routes.url_helpers.events_url(host: DOMAIN),
    source: Rails.application.routes.url_helpers.events_url(host: DOMAIN, format: :ics),
    name: 'IT events calendar',
    description: 'All IT events in 52 region'
  }.with_indifferent_access

  attr_reader :ical, :events

  def initialize(events)
    @events = events
    @ical   = Icalendar::Calendar.new
    @ical.prodid = DEFAULTS[:prodid]
    @ical.timezone do |t|
      t.tzid = Rails.configuration.time_zone
    end
    if events.respond_to?(:each)
      @events.each { |event| @ical.add_event(event.to_ics) }
    else
      @ical.add_event(events.to_ics)
    end
    @ical.publish
  end

  def to_ical
    lines = @ical.to_ical.lines
    injection = %i[url source name description].map do |key|
      [key.to_s.upcase, DEFAULTS[key]].join(':')
    end.join("\r\n")
    injection << "\r\nREFRESH-INTERVAL;VALUE=DURATION:PT12H\r\n"
    injection << "X-PUBLISHED-TTL:PT12H\r\n"
    lines.insert(4, injection).join
  end
end
