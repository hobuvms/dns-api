# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :validate_admin

  def validate_admin
    raise ExceptionHandler::AuthenticationError, 'Unauthorized Access' unless @current_user&.admin?
  end
end
