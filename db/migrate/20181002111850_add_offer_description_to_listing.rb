# frozen_string_literal: true

class AddOfferDescriptionToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :offer_description, :string
  end
end
