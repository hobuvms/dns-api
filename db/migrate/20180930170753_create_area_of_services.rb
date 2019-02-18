# frozen_string_literal: true

class CreateAreaOfServices < ActiveRecord::Migration[5.0]
  def change
    create_table :area_of_services do |t|
      t.string :name
      t.string :country
    end
  end
end
