class ContactsController < ApplicationController
  skip_before_action :authenticate_request
  def create
  	return render json: {message: "params missing"}, status: 422 if params[:message].blank?
  	OrderMailer.contact_us(params[:message]).deliver_later!
    render json: {message: :ok}, status: :ok
  end
end
