class AddInstallationTimeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :installation_time, :string
  end
end
