# frozen_string_literal: true

class CreateEventParticipations < ActiveRecord::Migration[4.2]
  def change
    create_table :event_participations do |t|
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
