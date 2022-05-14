# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  city       :string           not null
#  street     :string           not null
#  house      :string           not null
#  kladr_id   :string           not null
#  fias_id    :string           not null
#  lat        :float            not null
#  long       :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :address do
  end
end
