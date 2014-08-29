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

require 'spec_helper'

describe Event do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:organizer) }
  it { should validate_presence_of(:place) }
end
