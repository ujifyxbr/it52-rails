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

class Address < ApplicationRecord
  validates :unrestricted_value, presence: true, uniqueness: true
  validates :city, presence: true
  validates :street, presence: true
  validates :house, presence: true
  validates :kladr_id, presence: true
  validates :fias_id, presence: true
  validates :lat, presence: true
  validates :long, presence: true

  has_many :events

  def self.first_or_create_from_dadata(suggestion)
    address = find_by(unrestricted_value: suggestion['unrestricted_value'])
    return address if address

    address = build_from_dadata(suggestion)
    address.save!
    address
  end

  def self.build_from_dadata(suggestion)
    new(unrestricted_value: suggestion['unrestricted_value'],
        city: suggestion['data']['city'],
        street: suggestion['data']['street_with_type'],
        house: "#{suggestion['data']['house_type_full']} #{suggestion['data']['house']}",
        kladr_id: suggestion['data']['kladr_id'],
        fias_id: suggestion['data']['fias_id'],
        lat: suggestion['data']['geo_lat'].to_f,
        long: suggestion['data']['geo_lon'].to_f)
  end

  def to_s
    [city, street, house].join(', ')
  end
end
