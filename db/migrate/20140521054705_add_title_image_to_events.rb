# frozen_string_literal: true

class AddTitleImageToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :title_image, :string
  end
end
