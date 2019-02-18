# frozen_string_literal: true

class CalendarEventsController < ApplicationController
  # GET /calendar_events
  def index
    response = {
      availability_list: [
        {
          days: CalendarEvent.available_brackets(@current_user.id),
          repeated: 'WEEKLY', start_date: Date.today, end_date: Date.today + 6.days
        }
      ]
    }
    render_json(response)
  end

  def update_event
    data = params.as_json(only: %i[not_available available])
    CalendarEvent.update_events(@current_user.id, data)
    render_json(message: 'Updated!')
  rescue StandardError => e
    render_json({ message: e.message }, false, 422)
  end
end
