class AddPhoneToUserLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :user_leads, :phone, :string
  end
end
