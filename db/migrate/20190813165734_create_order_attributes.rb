class CreateOrderAttributes < ActiveRecord::Migration[5.0]
  def change
    create_table :order_attributes do |t|
      t.references :order, foreign_key: true
      t.integer :listing_attribute_id
      t.string :value
    end
  end
end
