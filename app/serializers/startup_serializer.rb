class StartupSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :logo, :description, :contacts
end
