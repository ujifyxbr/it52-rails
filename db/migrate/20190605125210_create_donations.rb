# frozen_string_literal: true

class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.float :amount,        null: false
      t.integer :kind,        null: false
      t.float :amount_in_rub, null: false

      t.timestamps
    end
  end
end
