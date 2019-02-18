# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :width
      t.integer :height
      t.string :format
      t.string :bytes
      t.string :url
      t.references :imageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
