class RemoveAndAddPhoneToUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :phone
  	add_column :users, :phone, :string
  end
end
