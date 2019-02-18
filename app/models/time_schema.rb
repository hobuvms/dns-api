# frozen_string_literal: true

class TimeSchema < ApplicationRecord
  scope :joins_calendar, lambda { |type, user_id|
                           joins("#{type} join calendar_events on
                           calendar_events.time_schema_id = time_schemas.id and
                           user_id = #{user_id} and event_type='not_available'")
                         }

  def self.table_schema(time)
    today_bracket = ((time.strftime('%H').to_i + 1) * 60)
    today_bracket += (1440 * time.wday)
    TimeSchema.where(time_value: today_bracket)
  end
end
