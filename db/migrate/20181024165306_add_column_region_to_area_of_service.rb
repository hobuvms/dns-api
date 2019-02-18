# frozen_string_literal: true

class AddColumnRegionToAreaOfService < ActiveRecord::Migration[5.0]
  def change
    add_column :area_of_services, :region, :string
  end
end
