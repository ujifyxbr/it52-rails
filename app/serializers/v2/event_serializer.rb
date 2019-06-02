module V2
  class EventSerializer
    include FastJsonapi::ObjectSerializer

    cache_options enabled: true, cache_length: 1.day
    set_key_transform :camel_lower

    attributes :id, :title, :created_at, :updated_at, :started_at, :published, :description, :title_image, :place, :slug, :foreign_link, :pageviews, :kind, :tag_list
    belongs_to :organizer
    has_many :participants

    link :url do |object|
      Rails.application.routes.url_helpers.event_url(object, host: ENV.fetch('mailing_host') { 'it52.info'} )
    end
  end
end
