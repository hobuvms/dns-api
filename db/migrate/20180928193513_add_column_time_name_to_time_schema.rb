# frozen_string_literal: true

class AddColumnTimeNameToTimeSchema < ActiveRecord::Migration[5.0]
  def change
    add_column :time_schemas, :time_name, :string
  end
end
