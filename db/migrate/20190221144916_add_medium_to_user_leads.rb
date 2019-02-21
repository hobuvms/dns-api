class AddMediumToUserLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :user_leads, :medium, :string
  end
end
