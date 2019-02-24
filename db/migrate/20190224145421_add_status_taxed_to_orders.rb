class AddStatusTaxedToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :status, :string
    add_column :orders, :taxed, :boolean
  end
end
