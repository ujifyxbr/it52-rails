class AddAvatarImageToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :avatar_image, :string
  end
end
