class AddNameToUserLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :user_leads, :name, :string
  end
end
