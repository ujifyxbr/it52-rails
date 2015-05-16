class AuthenticationSerializer < ActiveModel::Serializer
  cache key: 'authentication', expires_in: 3.hours
  attributes :id, :provider, :link
end
