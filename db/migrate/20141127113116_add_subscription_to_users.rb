class AddSubscriptionToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :subscription, :boolean
  end
end
