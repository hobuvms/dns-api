class AddNotesToUserLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :user_leads, :notes, :string
  end
end
