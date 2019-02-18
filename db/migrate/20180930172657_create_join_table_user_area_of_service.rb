# frozen_string_literal: true

class CreateJoinTableUserAreaOfService < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :area_of_services do |t|
      t.index %i[user_id area_of_service_id]
      t.index %i[area_of_service_id user_id]
    end
  end
end
