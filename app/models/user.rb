# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(128)      default(""), not null
#  password_salt          :string(255)      default(""), not null
#  created_at             :datetime
#  updated_at             :datetime
#  reset_password_token   :string(255)
#  name                   :string(255)
#  role                   :integer
#  first_name             :string(255)
#  last_name              :string(255)
#  bio                    :text
#  avatar_image           :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable, :omniauthable

  mount_uploader :avatar_image, UserAvatarUploader

  enum role: [ :member, :admin ]

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :owner_of_events, class_name: 'Event', foreign_key: 'organizer_id'
  has_many :event_participations
  has_many :member_in_events, class_name: 'Event', through: :event_participations, source: :event

  # validates :password, presence: true, if: :password_required?
  # validates :password, length: { minimum: 3 }, if: 'password.present?'
  # validates :password, confirmation: true, if: :password_required?

  # validates :email, presence: true, if: -> { :email_required? }

  before_create :assign_default_role, if: -> { role.nil? }

  def login
    name || email.split('@').first
  end

  def full_name
    [first_name, last_name].compact.join(' ').presence || login
  end

  def to_s
    full_name
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.oauth_data"]
        user = from_omniauth data
      end
    end
  end

  def self.from_omniauth(auth, current_user = nil)
    authentication = Authentication.where(provider: auth[:provider], uid: auth[:uid]).first_or_initialize
    user = current_user || authentication.user
    user ||= where(email: auth['info']['email']).first_or_create
    user.first_name = auth['info']['first_name']    if user.first_name.blank?
    user.last_name  = auth['info']['last_name']     if user.last_name.blank?
    user.bio        = auth['info']['description']   if user.bio.blank?
    user.remote_avatar_image_url = auth['info']['image'] if user.avatar_image.blank?
    user.name       = auth['info']['name'] || auth['info']['nickname'] if user.name.blank?

    authentication.link = auth['extra']['raw_info']['link'] || auth['info']['urls'].values.first
    authentication.token = auth['credentials']['token']
    authentication.token_expires = auth['credentials']['expires_at']

    user.authentications << authentication unless user.has_identity? auth[:provider]
    user.email = "" if user.email.nil?
    user.skip_confirmation! unless user.email_required?
    user.save
    user
  end

  def has_identity?(provider)
    provider.in? authentications.map(&:provider)
  end

  def password_required?
    super && authentications.blank?
  end

  def email_required?
    super && authentications.blank?
  end

  private

  def assign_default_role
    self.role = :member
  end
end
