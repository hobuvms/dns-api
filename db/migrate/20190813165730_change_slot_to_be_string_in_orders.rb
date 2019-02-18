class ChangeSlotToBeStringInOrders < ActiveRecord::Migration[5.0]
  def change
  	  change_column :orders, :slot, :string
  end
end
