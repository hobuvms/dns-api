# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:update]
  skip_before_action :authenticate_request, only: %i[login register user_exist reset_password change_password]

  # def current_user
  #   render_json(@current_user.as_object.merge(available_areas_of_service: AreaOfService.list))
  # end

  def update
    if current_vendor == @user
      if @user.update(user_update_params)
        render_json(@user.as_object, true, :ok)
      else
        render_json(@user.errors, false, :unprocessable_entity)
      end
    else
      render_json({ message: "You can not update other user's data" }, false, 401)
    end
  end

  def register
    @user = User.new(user_params.merge(role: :vendor))
    if @user.save
      auth = authenticate(params[:email], params[:password])
      # Send Mailer
      OrderMailer.vendor_sign_up(email: params[:email], name: @user.name, company: @user.company_name,
                                 referral: @user.referral_code, phone: @user.phone,
                                 location: @user.user_address&.formatted_address
                                ).deliver_now!
      response = { message: 'User created successfully' }.merge parse_user_detail(auth)
      render_json(response, true, :created)
    else
      render_json(@user.errors.full_messages, false, :unprocessable_entity)
    end
  end

  def login
    command = authenticate params[:email], params[:password]
    if command.success?
      data = parse_user_detail(command).merge(message: 'Login Successful')
      render_json(data, true, :created)
    else
      render_json({ error: command.errors }, false, :unauthorized)
    end
  end

  def user_exist
    user = User.where(email: params[:email])
    render_json({ message: "User Exist: #{user.present?}" }, user.present?, :ok)
  end

  def change_password
    validate_presence(params[:new_password], params[:verification_token])

    user = User.find_by_verification_token(params[:verification_token])
    return render_json({ message: 'Wrong Token or Token Expired' }, false, 404) if user.blank?

    user.change_password(password: params[:new_password])
    render_json({ message: 'Password Changed.' }, true, 200)
  end

  def reset_password
    return render_json({ message: 'Params Missing' }, false, 400) if params[:email].blank?

    user = User.find_by_email(params[:email])
    return render_json({ message: 'Email not Exist' }, false, 404) if user.blank?

    user.reset_password
    render_json({ message: 'Reset Password Link Sent.' })
  end

  private

  def parse_user_detail(command)
    { access_token: command.result[:token], object: command.result[:object] }
  end

  def set_user
    @user = Vendor.find(params[:id])
  end

  def authenticate(email, password)
    AuthenticateUser.call(email, password)
  end

  def user_params
    params.permit(:name, :email, :password, :phone, :company_name, :notes, user_address_attributes: [%w[formatted_address postal_code latitude longitude city country_name region_name]])
  end

  def user_update_params
    params.permit(:name, :password, :phone, :company_name, :notes, user_address_attributes: [%w[formatted_address postal_code latitude longitude city country_name region_name]])
  end
end
