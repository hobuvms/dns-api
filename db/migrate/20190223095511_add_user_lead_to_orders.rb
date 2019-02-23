class AddUserLeadToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :user_lead, foreign_key: true
  end
end
