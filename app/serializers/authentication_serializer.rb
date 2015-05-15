class AuthenticationSerializer < ActiveModel::Serializer
  attributes :id, :provider, :link
end
