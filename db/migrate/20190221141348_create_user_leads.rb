class CreateUserLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :user_leads do |t|
      t.references :user, foreign_key: true
      t.references :vendor

      t.timestamps
    end
   	add_foreign_key :user_leads, :users, column: :vendor_id, primary_key: :id
  end
end
