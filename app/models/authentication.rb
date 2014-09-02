# == Schema Information
#
# Table name: authentications
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  provider      :string(255)      not null
#  uid           :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#  link          :string(255)
#  token         :string(255)
#  token_expires :datetime
#

class Authentication < ActiveRecord::Base
  validates :uid, uniqueness: { scope: :provider }, presence: true
  validates :provider, presence: true

  belongs_to :user
end
