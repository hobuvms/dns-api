class AddReferralToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :referral, :string
  end
end
