# frozen_string_literal: true

class ApplicationController < ActionController::API
  :protect_from_forgery
  before_action :authenticate_request
  attr_reader :current_user

  include ExceptionHandler

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render_json({ error: 'Not Authorized' }, 401) unless @current_user
  end

  def render_json(data, success = true, status = :ok)
    render json: { success: success, data: data }, status: status
  end

  protected

  def validate_presence(*args)
    raise ActiveRecord::RecordNotFound, 'Params Missing' if args.any?(&:blank?)
  end
end
