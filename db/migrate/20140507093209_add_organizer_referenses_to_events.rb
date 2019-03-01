class AddOrganizerReferensesToEvents < ActiveRecord::Migration[4.2]
  def change
    add_reference :events, :organizer, index: true
  end
end
