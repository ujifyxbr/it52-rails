module V2
  class UserSerializer
    include FastJsonapi::ObjectSerializer

    cache_options enabled: true, cache_length: 1.day
    set_key_transform :camel_lower

    attributes :id, :email, :created_at, :updated_at, :started_at, :nickname, :role, :first_name, :last_name, :bio, :avatar_image, :slug, :website, :subscription, :employment

    link :url do |object|
      Rails.application.routes.url_helpers.user_url(object, host: ENV.fetch('mailing_host') { 'it52.info'} )
    end
  end
end
