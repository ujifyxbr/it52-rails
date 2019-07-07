# frozen_string_literal: true

class AddDescriptionAndStartedAtToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :description, :text
    add_column :events, :started_at, :datetime
  end
end
