class RenameUsersNameToNickname < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :name, :nickname
    change_column :users, :nickname, :string, uniq: true, index: true, default: ''
  end
end
