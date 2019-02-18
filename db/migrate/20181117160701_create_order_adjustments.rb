# frozen_string_literal: true

class CreateOrderAdjustments < ActiveRecord::Migration[5.0]
  def change
    create_table :order_adjustments do |t|
      t.string :order_uuid
      t.decimal :price
      t.string :notes
      t.integer :adjustment_type

      t.timestamps
    end
    add_index :order_adjustments, :order_uuid
    add_foreign_key :order_adjustments, :orders, column: :order_uuid, primary_key: :uuid
  end
end
