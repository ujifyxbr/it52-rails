# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.timestamps
    end
  end
end
