# frozen_string_literal: true

class CreateDnsPointLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :dns_point_logs do |t|
      t.references :user, foreign_key: true
      t.string :data

      t.timestamps
    end
  end
end
