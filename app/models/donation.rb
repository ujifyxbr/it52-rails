# == Schema Information
#
# Table name: donations
#
#  id            :bigint           not null, primary key
#  amount        :float            not null
#  kind          :integer          not null
#  amount_in_rub :float            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Donation < ApplicationRecord
  USD_RUB = 65

  validates :amount, presence: true, numericality: true
  validates :amount_in_rub, presence: true, numericality: true
  validates :kind, presence: true

  enum kind: {
    yandex_money: 0,
    humble_bundle: 1,
    paypal: 2,
    patreon: 3,
    cash: 4
  }

  before_validation :set_amount_in_rub

  def self.import_yandex_money(file)
    require 'csv'

    rows = CSV.read(file, col_sep: ';', skip_blanks: true)[5..-1]
    data = rows.select{ |val| val[5].include?('it52') }.map do |row|
      amount = row[2].gsub(',', '.').to_f
      { created_at: Time.zone.parse(row[1]),
        amount: amount,
        amount_in_rub: amount,
        kind: 0 }
    end
    create(data)
  end

  def self.import_humble_bundle(response)
    data = []

    response[:rows].group_by { |row| row[:date] }.each_pair do |month, rows|
      amount = rows.sum { |row| row[:net_usd] }.round(2)
      data << { created_at: Time.zone.parse("#{month}-01").end_of_month,
                amount: amount,
                amount_in_rub: (amount * USD_RUB).round(2),
                kind: 1 }
    end

    create(data)
  end

  private

  def set_amount_in_rub
    return unless amount
    self.amount_in_rub = yandex_money? ? amount : (amount * USD_RUB).round(2)
  end
end
