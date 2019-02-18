# frozen_string_literal: true

class ChangeStateToBeStringInOrders < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :state, :string
  end
end
