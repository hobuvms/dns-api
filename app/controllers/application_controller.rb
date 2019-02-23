class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

   rescue_from ActiveRecord::RecordNotFound do |exception|
    render_json(exception.message, false, 422)
  end


  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def render_json(message, success = true, status = :ok)
    render json: { data: message, success: success }, status: status
  end

  def current_vendor
    @current_user
  end
end
