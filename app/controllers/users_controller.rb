# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:update]
  skip_before_action :authenticate_request, only: %i[login register user_exist reset_password change_password]

  def current_user
    render_json(@current_user.as_object.merge(available_areas_of_service: AreaOfService.list))
  end

  def update
    if @current_user == @user
      if @user.update(user_params)
        @user.update_photo(params[:image_id]) if params[:image_id].present?
        render_json(@user.as_object, true, :ok)
      else
        render_json(@user.errors, false, :unprocessable_entity)
      end
    else
      render_json({ message: "You can not update other user's data" }, false, 401)
    end
  end

  def register
    @user = User.new(user_params)
    # @user.build_vendor_detail
    if @user.save
      auth = authenticate(params[:email], params[:password])
      response = { message: 'User created successfully' }.merge parse_user_detail(auth)
      render_json(response, true, :created)
    else
      render_json(@user.errors, false, :bad)
    end
  end

  def test
    render json: {
      message: 'You have passed authentication and authorization test'
    }
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

    user.change_password(params[:new_password])
    render_json({ message: 'Password Changed.' }, true, 200)
  end

  def reset_password
    return render_json({ message: 'Params Missing' }, false, 400) if params[:email].blank?

    user = User.find_by_email(params[:email])
    return render_json({ message: 'Email not Exist' }, false, 404) if user.blank?

    user.reset_password
    render_json({ message: 'Reset Password Link Sent.' }, true, 200)
  end

  private

  def parse_user_detail(command)
    { access_token: command.result[:object],
      user_detail: command.result[:model] }
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate(email, password)
    AuthenticateUser.call(email, password)
  end

  def user_params
    params.permit(:username, :first_name, :email, :password, :role, :last_name, :dob, :gender, :phone,
                  :first_name, :bio,
                  area_of_services_attributes: %i[name country],
                  vendor_detail_attributes: [:unit, :area, :city, :province, :postal_code,
                                               :latitude, :longitude, :address_text])
  end

  # Only allow a trusted parameter "white list" through.
  def user_data_params
    params.permit(:username, :first_name, :last_name, :email, :role, :password_digest, :password, :dns_points,
                  :dob, :gender, :phone)
  end
end
