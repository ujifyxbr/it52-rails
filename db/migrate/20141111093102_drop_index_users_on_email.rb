class DropIndexUsersOnEmail < ActiveRecord::Migration[4.2]
  def change
    remove_index :users, name: 'index_users_on_email'
  end
end
