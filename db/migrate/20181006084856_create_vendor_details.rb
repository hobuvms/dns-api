# frozen_string_literal: true

class CreateVendorDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :vendor_details do |t|
      t.integer :user_id
      t.integer :unit
      t.string :area
      t.string :city
      t.string :province
      t.string :postal_code
      t.integer :experience_level
      t.string :pitch
      t.integer :image1_id
      t.integer :image2_id

      t.timestamps
    end
  end
end
