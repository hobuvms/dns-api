class AddVerificationTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :verification_token, :string, index: true
  end
end
