# frozen_string_literal: true

class SorceryRememberMe < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :remember_me_token, :string, default: nil
    add_column :users, :remember_me_token_expires_at, :datetime, default: nil

    add_index :users, :remember_me_token
  end
end
