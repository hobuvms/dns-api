# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :role
      t.string :password_digest
      t.integer :dns_points
      t.datetime :dob
      t.integer :gender
      t.string :phone
      t.boolean :is_verified
      t.string :verification_token

      t.timestamps
    end
    add_index :users, :username
    add_index :users, :email
    add_index :users, :role
    add_index :users, :password_digest
  end
end
