class RemoveUserIdFromOrders < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :orders, name: "fk_rails_f868b47f6a"

  	remove_column :orders, :user_id

  end
end
