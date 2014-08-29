# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  link       :string(255)
#

class Authentication < ActiveRecord::Base
  belongs_to :user
  validates :uid, uniqueness: { scope: :provider }
end
