class AddAddressTextToVendorDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :vendor_details, :address_text, :string
  end
end
