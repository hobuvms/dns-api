# frozen_string_literal: true

class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.integer :views
      t.string :description
      t.integer :category_id
      t.boolean :disabled
      t.float :price_per_hour

      t.timestamps
    end
  end
end
