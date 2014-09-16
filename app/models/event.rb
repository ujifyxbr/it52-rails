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

  scope :ordered_desc, -> { order(started_at: :asc) }

  def user_participated?(user)
    user && event_participations.find_by(user_id: user.id)
  end

  def participation_for(user)
    event_participations.find_by(user_id: user.id)
  end

  def past?
    started_at < DateTime.now
  end

  def publish!
    self.toggle :published
    save!
  end

  def cancel_publication!
    self.toggle :published
    save!
  end
end
