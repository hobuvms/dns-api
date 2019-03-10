class WelcomesController < ApplicationController
  skip_before_action :authenticate_request

  def index
    render json: {success: true}
  end

end
