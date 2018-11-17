class AddPlaceToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :place, :string
  end
end
