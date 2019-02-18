class CreateListingAttributes < ActiveRecord::Migration[5.0]
  def change
    create_table :listing_attributes do |t|
      t.integer :listing_id
      t.string :attribute_name
    end
  end
end
