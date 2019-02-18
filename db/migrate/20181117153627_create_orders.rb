# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :uuid
      t.string :vendor_uuid
      t.decimal :total
      t.integer :state
      t.integer :listing_id
      t.integer :slot
      t.datetime :scheduled_at

      t.timestamps
    end
    add_index :orders, :uuid
    add_index :orders, :vendor_uuid
    add_foreign_key :orders, :users, column: :vendor_uuid, primary_key: :uuid
  end
end
