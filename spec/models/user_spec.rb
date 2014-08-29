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

require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it 'has default(member) role after creation' do
    expect(subject.role).to eq 'member'
  end
end
