# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def forgot_password(user_id, _token)
    user = User.find_by_id(user_id)
    @token = user.verification_token
    message = build_message(user.email, 'Reset Password Request', build_body)
    send_mail user.email, message
  end
end
