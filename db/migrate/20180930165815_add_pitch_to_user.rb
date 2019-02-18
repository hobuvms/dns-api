# frozen_string_literal: true

class AddPitchToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pitch, :text
  end
end
