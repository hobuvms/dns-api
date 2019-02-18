# frozen_string_literal: true

# app/auth/authenticate_user.rb
class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :email, :password

  # this is where parameters are taken when the command is called
  def initialize(email, password)
    @email = email
    @password = password
  end

  # this is where the result gets returned
  def call
    { object: JsonWebToken.encode(user_id: user.id), model: user.as_object } if user
  end

  private

  def user
    user = User.find_by_email(email)
    return user if user&.authenticate(password)

    errors.add :user_authentication, 'Invalid credentials'
    nil
  end
end
