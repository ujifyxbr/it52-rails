# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#  organizer_id :integer
#  published    :boolean          default(FALSE)
#  description  :text
#  started_at   :datetime
#  title_image  :string(255)
#  place        :string(255)
#

class Event < ActiveRecord::Base
  mount_uploader :title_image, EventTitleImageUploader

  belongs_to :organizer, class_name: 'User'

  has_many :event_participations
  has_many :participants, class_name: 'User', through: :event_participations, source: :user

  validates :title, presence: true
  validates :organizer, presence: true
  validates :place, presence: true
  validates :description, presence: true
  validates :started_at, presence: true

  scope :ordered_desc,  -> { order(started_at: :desc) }
  scope :ordered_asc,   -> { order(started_at: :asc) }

  scope :published, -> { where(published: true) }

  scope :past,    -> { ordered_desc.where("started_at < ?", Time.now.beginning_of_day ) }
  scope :future,  -> { ordered_asc.where("started_at >= ?", Time.now.beginning_of_day ) }

  def user_participated?(user)
    user && event_participations.find_by(user_id: user.id)
  end

  def participation_for(user)
    event_participations.find_by(user_id: user.id)
  end

  def past?
    started_at < Time.now
  end

  def publish!
    self.published_at = Time.now
    self.toggle :published
    save!
  end

  def cancel_publication!
    self.toggle :published
    save!
  end

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = self.started_at.strftime("%Y%m%dT%H%M%S")
    event.summary = self.title
    event.description = self.description
    event.location = self.place
    event.created = self.created_at
    event.last_modified = self.updated_at
    # TODO: remove hardcoded line
    event.uid = event.url = "http://it52.info/events/#{self.id}"
    event
  end
end
