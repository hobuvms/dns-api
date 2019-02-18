# frozen_string_literal: true

class AddExperienceLevelToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :experience_level, :integer
  end
end
