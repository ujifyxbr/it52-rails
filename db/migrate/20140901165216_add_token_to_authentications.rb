# frozen_string_literal: true

class AddTokenToAuthentications < ActiveRecord::Migration[4.2]
  def change
    add_column :authentications, :token, :string
    add_column :authentications, :token_expires, :datetime
  end
end
