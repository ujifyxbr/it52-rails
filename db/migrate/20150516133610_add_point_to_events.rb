class AddPointToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :location, :point, geographic: true
  end
end
