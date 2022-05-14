# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  title           :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  organizer_id    :integer
#  published       :boolean          default(FALSE)
#  description     :text
#  started_at      :datetime
#  title_image     :string(255)
#  place           :string(255)
#  published_at    :datetime
#  slug            :string(255)
#  location        :point
#  foreign_link    :string
#  pageviews       :integer          default(0)
#  kind            :integer          default("event")
#  address_id      :bigint
#  address_comment :string
#

class EventSerializer < ActiveModel::Serializer
  cache key: 'event', expires_in: 3.hours
  attributes :id, :title, :description, :image_url, :place, :started_at, :started_at_js, :url, :location, :organizer, :tag_list

  has_many :participants, each_serializer: UserSerializer
  belongs_to :organizer

  def image_url
    object.title_image.square_500.url
  end

  def started_at_js
    object.started_at.to_f * 1000
  end

  def url
    Rails.application.routes.url_helpers.event_url(object, host: ENV.fetch('mailing_host') { 'mailing_host' })
  end
end
