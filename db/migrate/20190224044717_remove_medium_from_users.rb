class RemoveMediumFromUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :medium
  end
end
