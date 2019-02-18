class CreateCustomerAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_addresses do |t|
      t.references :user, foreign_key: true
      t.references :order, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.string :full_address
      t.integer :phone

      t.timestamps
    end
  end
end
