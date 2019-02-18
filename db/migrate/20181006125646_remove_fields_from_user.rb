# frozen_string_literal: true

class RemoveFieldsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :experience_level, :integer
    remove_column :users, :pitch, :string
  end
end
