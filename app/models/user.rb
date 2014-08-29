# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string(255)
#  crypted_password                :string(255)
#  salt                            :string(255)
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  last_login_at                   :datetime
#  last_logout_at                  :datetime
#  last_activity_at                :datetime
#  last_login_from_ip_address      :string(255)
#  name                            :string(255)
#  role                            :integer
#  first_name                      :string(255)
#  last_name                       :string(255)
#  bio                             :text
#  avatar_image                    :string(255)
#

class User < ActiveRecord::Base
  mount_uploader :avatar_image, UserAvatarUploader

  authenticates_with_sorcery!

  enum role: { member: 0, admin: 1 }

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :owner_of_events, class_name: 'Event', foreign_key: 'organizer_id'
  has_many :event_participations
  has_many :member_in_events, class_name: 'Event', through: :event_participations, source: :event

  validates :password, presence: true, if: :password_required?
  validates :password, length: { minimum: 3 }, if: 'password.present?'
  validates :password, confirmation: true, if: :password_required?

  validates :email, presence: true, if: :email_required?
  validates :email, uniqueness: true, if: :email_required?

  before_create :assign_default_role, if: -> { role.nil? }

  def login
    name || email.split('@').first
  end

  def full_name
    [first_name, last_name].compact.join(' ').presence || login
  end

  private

  def password_required?
    (new_record? && authentications.empty?) || password.present?
  end

  def email_required?
    authentications.empty? || name.blank?
  end

  private

  def assign_default_role
    self.role = :member
  end
end
