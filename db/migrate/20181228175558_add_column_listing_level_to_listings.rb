class AddColumnListingLevelToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :listing_level, :integer, default: 1
    add_index :listings, :listing_level
  end
end
