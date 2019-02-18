# frozen_string_literal: true

class CreateCalendarEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :calendar_events do |t|
      t.references :time_schema, foreign_key: true
      t.integer :event_type
      t.references :listing
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
