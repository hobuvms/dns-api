# frozen_string_literal: true

class CreateOrderTrackingDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_tracking_details do |t|
      t.string :order_uuid
      t.string :state
      t.string :notes

      t.timestamps
    end
    add_index :order_tracking_details, :order_uuid
    add_foreign_key :order_tracking_details, :orders, column: :order_uuid, primary_key: :uuid
  end
end
