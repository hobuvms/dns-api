class ChangeNotesFromJsonToString < ActiveRecord::Migration[5.0]
  def change
  	change_column :order_details, :notes, :string
  end
end
