# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :unrestricted_value, null: false
      t.string :city,               null: false
      t.string :street,             null: false
      t.string :house,              null: false
      t.string :kladr_id,           null: false
      t.string :fias_id,            null: false
      t.float  :lat,                null: false
      t.float  :long,               null: false

      t.timestamps
    end
  end
end
