# frozen_string_literal: true

class AddOfferPriceToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :offer_price, :integer
  end
end
