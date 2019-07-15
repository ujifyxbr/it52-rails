# frozen_string_literal: true

class AddLinkToAuthentications < ActiveRecord::Migration[4.2]
  def change
    add_column :authentications, :link, :string
  end
end
