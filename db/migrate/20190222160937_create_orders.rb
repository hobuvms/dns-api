class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :vendor
      t.references :user, foreign_key: true
      t.integer :product_id
      t.string :account_number
      t.string :working_order
      t.string :company_name
      t.float :price
      t.datetime :installation
      t.datetime :expiry_date
      t.string :details

      t.timestamps
    end

    add_foreign_key :orders, :users, column: :vendor_id, primary_key: :id
  end
end
