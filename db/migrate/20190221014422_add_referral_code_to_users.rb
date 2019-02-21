class AddReferralCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :referral_code, :string
    add_index :users, :referral_code
  end
end
