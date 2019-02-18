class AddColumnApproxTaxAndSourceToOrderDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :order_details, :approx_tax, :boolean
    add_column :order_details, :source, :string
  end
end
