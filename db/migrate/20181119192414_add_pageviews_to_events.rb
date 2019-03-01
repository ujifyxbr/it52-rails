class AddPageviewsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :pageviews, :integer, default: 0
  end
end
