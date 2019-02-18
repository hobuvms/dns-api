# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string :url
      t.string :name

      t.timestamps
    end
    add_index :categories, :parent_id
  end
end
