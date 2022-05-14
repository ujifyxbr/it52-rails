# frozen_string_literal: true

module V2
  class EventSerializer
    include FastJsonapi::ObjectSerializer

    cache_options enabled: true, cache_length: 1.day
    set_key_transform :camel_lower

    attributes :title, :created_at, :updated_at, :started_at, :published, :description, :title_image, :place, :slug, :foreign_link, :pageviews, :kind, :tag_list

    attribute :participants_count

    belongs_to :organizer, record_type: :user, serializer: :user
    has_many :participants, record_type: :user,
                            serializer: :user,
                            if: proc { |_record, params| params[:action] != 'index' }

    link :url do |object|
      Rails.application.routes.url_helpers.event_url(object, host: ENV.fetch('mailing_host') { 'it52.info' })
    end
  end
end
