class AddAddressIdToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :address, foreign_key: true
    add_column :events, :address_comment, :string
  end
end
