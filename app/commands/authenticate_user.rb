class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    if user
      { token: encode(user_id: user.id), object: user.as_object }
    else
      {}
    end
  end

  private

    def encode(payload, exp = 24.hours.from_now)
     payload[:exp] = exp.to_i
     JWT.encode(payload, Rails.application.secrets.secret_key_base)
   end

  attr_accessor :email, :password

  def user
    user = Vendor.find_by_email(email)
    return user if user && user.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end