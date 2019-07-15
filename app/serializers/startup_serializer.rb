# frozen_string_literal: true

class StartupSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :logo, :description, :contacts
end
