# frozen_string_literal: true

class CreateTimeSchemas < ActiveRecord::Migration[5.0]
  def change
    create_table :time_schemas do |t|
      t.integer :time_value
      t.string :day_name
    end
  end
end
