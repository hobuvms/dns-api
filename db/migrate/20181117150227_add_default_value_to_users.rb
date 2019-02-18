# frozen_string_literal: true

class AddDefaultValueToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:users, :role, 100)
  end
end
