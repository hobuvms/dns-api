class AddLatitudeAndLongitudeToVendorDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :vendor_details, :latitude, :string
    add_column :vendor_details, :longitude, :string
  end
end
