# frozen_string_literal: true

class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.string :order_uuid
      t.decimal :per_hour_cost
      t.float :duration
      t.string :ip
      t.integer :device
      t.string :notes

      t.timestamps
    end
    add_index :order_details, :order_uuid
    add_foreign_key :order_details, :orders, column: :order_uuid, primary_key: :uuid
  end
end
