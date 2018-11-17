class AddPublishedToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :published, :boolean, default: false
  end
end
