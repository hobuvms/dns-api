# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
    rescue_from ExceptionHandler::DecodeError, with: :four_zero_one

    rescue_from ActiveRecord::RecordNotFound do |e|
      render_json({ message: e.message }, false, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(exception_object)
    render json: { message: exception_object.message }, status: :unprocessable_entity
  end

  # JSON response with message; Status code 401 - Unauthorized
  def four_ninety_eight(exception_object)
    render json: { message: exception_object.message }, status: :invalid_token
  end

  # JSON response with message; Status code 401 - Unauthorized
  def four_zero_one(exception_object)
    render json: { message: exception_object.message }, status: :invalid_token
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(exception_object)
    render_json({ message: exception_object.message }, false, :unauthorized)
  end
end
