# frozen_string_literal: true

class AddUserToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :user_uuid, :string
    add_index :orders, :user_uuid
    add_foreign_key :orders, :users, column: :user_uuid, primary_key: :uuid
  end
end
