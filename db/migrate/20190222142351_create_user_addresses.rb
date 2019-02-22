class CreateUserAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_addresses do |t|
      t.references :user, foreign_key: true
      t.string :formatted_address
      t.string :postal_code
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :country_name
      t.string :region_name

      t.timestamps
    end
  end
end
