class AddNotesAndMediumToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :notes, :string
    add_column :users, :medium, :string
  end
end
