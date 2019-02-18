# frozen_string_literal: true

class CalendarEvent < ApplicationRecord
  belongs_to :time_schema
  # belongs_to :listing
  belongs_to :user
  enum event_type: %i[not_available customer_order]

  def self.available_brackets(user_id = 1)
    TimeSchema.joins_calendar('left', user_id)
              .select('(time_value - 60) start_time, time_value end_time')
              .select(%i[day_name])
              .where('calendar_events.id is null')
              .group_by { |x| x['day_name'] }
              .map { |k, v| { day: k, free_slot: v } }
  end

  def self.events_brackets(user_id = 1)
    CalendarEvent.joins('inner join time_schemas on time_schemas.id = time_schema_id')
                 .select(%i[event_type created_at day_name])
                 .select('(time_value - 60) start_time, time_value end_time')
                 .where(user_id: user_id).customer_order
                 .group_by { |x| x['day_name'] }
  end

  def self.clear_data(day, user_id, customer_order_only = true)
    raise 'Invalid Data' if Date::DAYNAMES.exclude? day

    data = CalendarEvent.joins('inner join time_schemas on time_schemas.id =time_schema_id')
                        .where(user_id: user_id)
                        .where('day_name = ?', day)
    data = data.where(event_type: 'customer_order') if customer_order_only
    data.delete_all
  end

  def self.update_events(user_id, data = {})
    data.each do |key, value|
      case key.to_s
      when 'not_available'
        mark_unavailable(user_id, value, :not_available)
      when 'available'
        mark_available(user_id, value)
      end
    end
  end

  def self.mark_unavailable(user_id, time_brackets, type)
    time_brackets.each do |time_bracket|
      time_data = TimeSchema.where(time_value: time_bracket)[0]
      raise "Invalid Data #{time_bracket}" if time_data.blank?

      find_or_create_by!(event_type: type, time_schema_id: time_data.id, user_id: user_id)
    end
  end

  def self.mark_available(user_id, time_brackets)
    time_data_id = TimeSchema.where(time_value: time_brackets).pluck(:id)
    raise "Invalid Data #{time_brackets}" if time_data_id.blank?

    where(event_type: :not_available, time_schema_id: time_data_id, user_id: user_id).delete_all
  end
end
