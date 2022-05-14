# frozen_string_literal: true

class AddForeignLinkToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :foreign_link, :string
  end
end
