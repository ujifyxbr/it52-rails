# frozen_string_literal: true

class NullableSorceryCore < ActiveRecord::Migration[4.2]
  def change
    change_column_null(:users, :email, true)
    change_column_null(:users, :crypted_password, true)
    change_column_null(:users, :salt, true)
  end
end
