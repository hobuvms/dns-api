# frozen_string_literal: true

class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.references :user, foreign_key: true
      t.string :friend_email
      t.string :code
      t.boolean :valid

      t.timestamps
    end
    add_index :invitations, :code
  end
end
