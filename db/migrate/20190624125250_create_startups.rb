# frozen_string_literal: true

class CreateStartups < ActiveRecord::Migration[5.2]
  def change
    create_table :startups do |t|
      t.string :title, null: false, index: true
      t.string :url
      t.string :slug, index: true
      t.string :logo
      t.string :intro
      t.text :description,  null: false
      t.jsonb :contacts,    default: { name: '', email: '' }
      t.references :author, null: false, index: true

      t.timestamps
    end
  end
end
