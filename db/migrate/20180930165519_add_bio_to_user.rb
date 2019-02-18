# frozen_string_literal: true

class AddBioToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bio, :text
  end
end
